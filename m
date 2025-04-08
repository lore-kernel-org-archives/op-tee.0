From: Stauffer Thomas MTANA <Thomas.Stauffer@mt.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Extract RPMB Key
Date: Tue, 08 Apr 2025 13:29:14 +0000
Message-ID: <GVXPR03MB1046013B0D70D9FAC1CEDE85E8AB52@GVXPR03MB10460.eurprd03.prod.outlook.com>
In-Reply-To: <a830f81e-17b9-4dc7-9853-42c3660b5866@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7812086547738005052=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7812086547738005052==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the feedback, I will create a PR then.

Thomas

________________________________
From: Jerome Forissier
Sent: Tuesday, April 08, 2025 14:32
To: Stauffer Thomas MTANA; op-tee(a)lists.trustedfirmware.org
Subject: Re: EXTERNAL - Extract RPMB Key

Hi,

On 4/8/25 13:35, Stauffer Thomas MTANA wrote:
> As far as I understand there are currently two possibilities to setup an RP=
MB with an appropriate key.
>
> 1. Use a specialized OP-TEE with CFG_RPMB_WRITE_KEY=3Dy during production i=
n an environment were leaking the key is ok.
> 2. Get the HUK, get the CID from the MMC, then use scripts/derive_rpmb_key.=
py to calculate the RPMB key and set e.g. via mmc tool.
>> I've the impression when I read through some message on https://github.com=
/OP-TEE/optee_os/issues, that 1 is not considered the best idea.

Correct. CFG_RPMB_WRITE_KEY was implemented as an quick and easy solution for=
 a development environment, especially for CI with QEMU. Then scripts/derive_=
rpmb_key.py was introduced as a potentially better option for production, but=
 I guess not all production environments are the same so it may have its shor=
tcomings.

> Currently I'm working on a iMX8M platform and using CFG_RPMB_WRITE_KEY also=
 has the drawback to use the legacy RPMB interface, which makes tee-supplican=
t still necessary, which otherwise would not be needed.

Indeed. The ability to write the key was left out on purpose.

> The problem at least on iMX8M is that its not easy possible to get the HUK,=
 and the HUK also is different, depending if a device is in a closed state or=
 not. To extract the whole HUK, even in a sensible environment during product=
ion, seems unnecessary.
>
> What I did now, something very simple. I extended tee_rpmb_fs.c a little bi=
t and made a function which allows to retrieve the RPMB key, I added also a t=
iny PTA, and a corresponding user space application to get the RPMB key, only=
 as long CFG_INSECURE is set, therefore also only a specialized OP-TEE build =
can provide this functionality.
>
> Someone can now decide to get the RPMB key either before the device is clos=
ed (for testing devices), or afterwards. Write then the RPMB key manually (e.=
g. via mmc tool) and/or also store it securly in a production data database.
>
> What would be the advantages, compared to CFG_RPMB_WRITE_KEY=3Dy
>
> - HUK is still not leaked, as it may be used to derive other secrets
> - derive_rpmb_key.py is not necessary
> - It is guaranteed that the correct RPMB key is retrieved, 100% matches how=
 OP-TEE was configured (e.g. with compat mode enabled or not)
> - Because the RPMB key is known, one can manually still delete the RPMB and=
 see how OP-TEE handles this situation, at least during development
> - Testing this functionality also on an open device (which is currently not=
 possible at least on iMX8M, due to plat_rpmb_key_is_ready)
>
> My question is, if there would be any interest to open a PR, so other peopl=
e also can use this?

I would encourage you to do so, especially since you have the code already. P=
eople using i.MX platforms will likely be interested and provide useful feedb=
ack -- I mean better than mine :)

Thanks,
--
Jerome

--===============7812086547738005052==--

