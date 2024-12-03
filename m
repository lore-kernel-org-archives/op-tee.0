From: Krzysztof Kozlowski <krzk@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 08/10] tee: add Qualcomm TEE driver
Date: Tue, 03 Dec 2024 08:57:57 +0100
Message-ID: <00e3bd13-eab8-47b0-b577-dfdb3bd5900e@kernel.org>
In-Reply-To: <=?utf-8?q?=3C20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-?=
 =?utf-8?q?8-f502ef01e016=40quicinc=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8534084498514345422=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8534084498514345422==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On 03/12/2024 05:19, Amirreza Zarrabi wrote:
> +static const struct tee_desc qcom_tee_desc = {
> +	.name = "qcom_tee",
> +	.ops = &qcom_tee_ops,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int qcom_tee_probe(struct platform_device *pdev)
> +{
> +	struct tee_device *teedev;
> +	int err;
> +
> +	if (!qcom_scm_is_available())
> +		return -EPROBE_DEFER;

So this is part of SCM? Instantiate it there instead of creating fake
DTS nodes.

> +
> +	teedev = tee_device_alloc(&qcom_tee_desc, NULL, NULL, NULL);
> +	if (IS_ERR(teedev))
> +		return PTR_ERR(teedev);
> +
> +	err = tee_device_register(teedev);
> +	if (err)
> +		goto err_unreg_teedev;
> +
> +	platform_set_drvdata(pdev, teedev);
> +	return 0;
> +
> +err_unreg_teedev:
> +	tee_device_unregister(teedev);
> +
> +	return err;
> +}
> +
> +static void qcom_tee_remove(struct platform_device *pdev)
> +{
> +	struct tee_device *teedev = platform_get_drvdata(pdev);
> +
> +	/* Keep a copy, tee_device_unregister() sets it to NULL. */
> +	struct tee_shm_pool *pool = teedev->pool;
> +
> +	/* Wait for users to go away. */
> +	tee_device_unregister(teedev);
> +	tee_shm_pool_free(pool);
> +}
> +
> +static const struct of_device_id qcom_tee_dt_match[] = {
> +	{ .compatible = "qcom,tee" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, qcom_tee_dt_match);
> +
> +static struct platform_driver qcom_tee_platform_driver = {
> +	.probe = qcom_tee_probe,
> +	.remove = qcom_tee_remove,
> +	.driver = {
> +		.name = "qcom_tee",
> +		.of_match_table = qcom_tee_dt_match,
> +	},
> +};
> +
> +int qcom_tee_driver_register(void)
> +{
> +	return platform_driver_register(&qcom_tee_platform_driver);
> +}
> +
> +void qcom_tee_driver_unregister(void)
> +{
> +	platform_driver_unregister(&qcom_tee_platform_driver);
> +}

Why open-coding typical module platform driver macro?


Best regards,
Krzysztof

--===============8534084498514345422==--

