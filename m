From: Bart Van Assche <bvanassche@acm.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB) driver
Date: Mon, 07 Aug 2023 21:02:22 +0000
Message-ID: <7c8945be-2549-ee79-fbdf-4870eca6f908@acm.org>
In-Reply-To: <20230722014037.42647-2-shyamsaini@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5748818876795758543=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5748818876795758543==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 7/21/23 18:40, Shyam Saini wrote:
> +config RPMB
> +	tristate "RPMB partition interface"
> +	help
> +	  Unified RPMB partition interface for RPMB capable devices such as
> +          eMMC and UFS. Provides interface for in kernel security controll=
ers to
> +	  access RPMB partition.
> +
> +	  If unsure, select N.

Please also mention NVMe.

Please change the word "partition" into "unit" to avoid confusion with=20
the concept "LBA range partition".

> +static DEFINE_IDA(rpmb_ida);

How are accesses to this IDA serialized?

> +/**
> + * rpmb_get_capacity() - returns the capacity of the rpmb device
> + * @rdev: rpmb device
> + *
> + * Return:
> + * *        capacity of the device in units of 128K, on success
> + * *        -EINVAL on wrong parameters
> + * *        -EOPNOTSUPP if device doesn't support the requested operation
> + * *        < 0 if the operation fails
> + */

Why in units of 128 KiB?

> +/**
> + * rpmb_dev_find_by_device() - retrieve rpmb device from the parent device
> + * @parent: parent device of the rpmb device
> + * @target: RPMB target/region within the physical device
> + *
> + * Return: NULL if there is no rpmb device associated with the parent devi=
ce
> + */

Can an NVMe controller have multiple RPMB units? From the NVMe=20
specification: "The controller may support multiple RPMB targets."

Can rpmb_dev_find_by_device() be used if multiple RPMB units are=20
associated with a single controller?

> +/**
> + * rpmb_dev_register - register RPMB partition with the RPMB subsystem
> + * @dev: storage device of the rpmb device
> + * @target: RPMB target/region within the physical device
> + * @ops: device specific operations
> + *
> + * Return: a pointer to rpmb device
> + */
> +struct rpmb_dev *rpmb_dev_register(struct device *dev, u8 target,
> +				   const struct rpmb_ops *ops)
> +{
> +	struct rpmb_dev *rdev;
> +	int id;
> +	int ret;
> +
> +	if (!dev || !ops)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!ops->program_key)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!ops->get_capacity)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!ops->get_write_counter)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!ops->write_blocks)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!ops->read_blocks)
> +		return ERR_PTR(-EINVAL);
> +
> +	rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
> +	if (!rdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	id =3D ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
> +	if (id < 0) {
> +		ret =3D id;
> +		goto exit;
> +	}
> +
> +	mutex_init(&rdev->lock);
> +	rdev->ops =3D ops;
> +	rdev->id =3D id;
> +	rdev->target =3D target;
> +
> +	dev_set_name(&rdev->dev, "rpmb%d", id);
> +	rdev->dev.class =3D &rpmb_class;
> +	rdev->dev.parent =3D dev;
> +
> +	rpmb_cdev_prepare(rdev);
> +
> +	ret =3D device_register(&rdev->dev);
> +	if (ret)
> +		goto exit;
> +
> +	rpmb_cdev_add(rdev);
> +
> +	dev_dbg(&rdev->dev, "registered device\n");
> +
> +	return rdev;
> +
> +exit:
> +	if (id >=3D 0)
> +		ida_simple_remove(&rpmb_ida, id);
> +	kfree(rdev);
> +	return ERR_PTR(ret);
> +}

How is user space software supposed to map an NVMe RPMB target ID to an=20
RPMB device name?

> +MODULE_AUTHOR("Intel Corporation");

Shouldn't this be the name of a person instead of the name of a company?

Thanks,

Bart.

--===============5748818876795758543==--

