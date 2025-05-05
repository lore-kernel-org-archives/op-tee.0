From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 06/11] firmware: qcom: scm: remove unused arguments to
 the shm_brige
Date: Tue, 06 May 2025 09:18:49 +1000
Message-ID: <2a0df02a-1657-4b59-8f31-791a8aff523e@oss.qualcomm.com>
In-Reply-To: <246da659-2add-4ccf-b914-f737fb93f3f2@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8199628527749787846=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8199628527749787846==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 5/5/2025 8:58 PM, Kuldeep Singh wrote:
>=20
>=20
> On 4/29/2025 11:36 AM, Amirreza Zarrabi wrote:
>> shm_bridge create/delete functions always use the scm device.
>> There is no need to pass it as an argument.
>>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>=20
>=20
> There are 2 type of APIs exposed by tzmem driver for pool creation.
> devm_qcom_tzmem_pool_new and qcom_tzmem_pool_new.
>=20
> Device managed pool is created with devm_qcom_tzmem_pool_new but
> currently qcom_scm is using it's own dev to create/delete bridge which
> is problamatic here.
>=20
> https://elixir.bootlin.com/linux/v6.14.5/source/drivers/firmware/qcom/qcom_=
scm.c#L1653
>=20
> If pool is device managed, same dev should be used in qcom_scm to
> create/delete bridge rather than using qcom_scm dev.
> The dev passed as an argument to function should be used instead of
> __scm->dev.
> https://elixir.bootlin.com/linux/v6.14.5/source/drivers/firmware/qcom/qcom_=
scm.c#L1634
>=20
> To summarize, I believe correct solution should be to pass corresponding
> dev to bridge create/delete APIs instead of always assuming to be
> qcom_scm dev for devm_qcom_tzmem_pool_new scenarios.
> For qcom_tzmem_pool_new, qcom_scm/qcom_tzmem_dev can be used.
>=20
> Bartosz/Amirreza, please share your thoughts as well.
>=20

It is not true.
Why should shmbridge need to have access to random devices, while the resourc=
es
are obtained from the scm device, if any?

- Amir

--===============8199628527749787846==--

