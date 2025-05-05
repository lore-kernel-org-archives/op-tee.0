From: Kuldeep Singh <quic_kuldsing@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 06/11] firmware: qcom: scm: remove unused arguments to
 the shm_brige
Date: Mon, 05 May 2025 16:28:51 +0530
Message-ID: <246da659-2add-4ccf-b914-f737fb93f3f2@quicinc.com>
In-Reply-To: <=?utf-8?q?=3C20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-?=
 =?utf-8?q?6-6a143640a6cb=40oss=2Equalcomm=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5085232240736934836=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5085232240736934836==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 4/29/2025 11:36 AM, Amirreza Zarrabi wrote:
> shm_bridge create/delete functions always use the scm device.
> There is no need to pass it as an argument.
>=20
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>


There are 2 type of APIs exposed by tzmem driver for pool creation.
devm_qcom_tzmem_pool_new and qcom_tzmem_pool_new.

Device managed pool is created with devm_qcom_tzmem_pool_new but
currently qcom_scm is using it's own dev to create/delete bridge which
is problamatic here.

https://elixir.bootlin.com/linux/v6.14.5/source/drivers/firmware/qcom/qcom_sc=
m.c#L1653

If pool is device managed, same dev should be used in qcom_scm to
create/delete bridge rather than using qcom_scm dev.
The dev passed as an argument to function should be used instead of
__scm->dev.
https://elixir.bootlin.com/linux/v6.14.5/source/drivers/firmware/qcom/qcom_sc=
m.c#L1634

To summarize, I believe correct solution should be to pass corresponding
dev to bridge create/delete APIs instead of always assuming to be
qcom_scm dev for devm_qcom_tzmem_pool_new scenarios.
For qcom_tzmem_pool_new, qcom_scm/qcom_tzmem_dev can be used.

Bartosz/Amirreza, please share your thoughts as well.

--=20
Regards
Kuldeep


--===============5085232240736934836==--

