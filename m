From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 0/2] OP-TEE FF-A notifications
Date: Tue, 07 Nov 2023 11:46:30 +0000
Message-ID: <20231107114630.GE954129@bogus>
In-Reply-To: <20231026080409.4149616-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2572867777814209407=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2572867777814209407==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 10:04:07AM +0200, Jens Wiklander wrote:
> Hi all,
>=20
> This patchset adds support for using FF-A notifications as a delivery
> mechanism of asynchronous notifications from OP-TEE running in the secure
> world. Support for asynchronous notifications via the SMC ABI was added in
> [1], here we add the counterpart needed when using the the FF-A ABI.
>=20
> Support for FF-A notifications is added with [2] and this patch set is based
> on Sudeeps tree at [3].
>=20
> [1] https://lore.kernel.org/lkml/20211103090255.998070-1-jens.wiklander(a)l=
inaro.org/
> [2] https://lore.kernel.org/linux-arm-kernel/20231005-ffa_v1-1_notif-v4-0-c=
ddd3237809c(a)arm.com/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/=
tag/?h=3Dffa-updates-6.7
>     commit bcefd1bf63b1 ("firmware: arm_ffa: Upgrade the driver version to =
v1.1")
>=20

FWIW:

Tested-by: Sudeep Holla <sudeep.holla@arm.com>

--=20
Regards,
Sudeep

--===============2572867777814209407==--

