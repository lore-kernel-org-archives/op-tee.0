From: Gabor Toth <Gabor.Toth2@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Enable pointer authentication for the SP initialization
Date: Tue, 25 Jun 2024 11:16:16 +0000
Message-ID: <VI1PR08MB10174969BD2C9A746B4C45EBAA9D52@VI1PR08MB10174.eurprd08.prod.outlook.com>
In-Reply-To: <=?utf-8?q?=3CVI1PR08MB101749C09F63F4CD472C3789FA9CD2=40VI1PR08M?=
 =?utf-8?q?B10174=2Eeurprd08=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0902479194788789978=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0902479194788789978==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Guys,

Currently pointer authentication is disabled at the beginning of the SP-s and=
 is enabled after boot_init_primary_late here:
https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/kernel/entry_a64=
.S#L385

We would like to have it already enabled when the SP starts running to protec=
t all the code and to also avoid problems like having the feature enabled bet=
ween a paciasp-autiasp pair.
I tried moving the feature enablement right before the initialization of the =
SP-s, here:
https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/kernel/boot.c#L1=
064

When __thread_enter_user_mode is called thread_core_local[0] keys are used by=
 the feature, but before switching to user mode the related registers are set=
 to threads[0].keys and not returned to the original values resulting in exce=
ption.

I see three possible ways to solve this:

  *   Enable PAC before SP initialization is started and restore the original=
 keys in functions that change them if the feature is enabled.
  *   Enable PAC before SP initialization is started and disable the protecti=
on (by attribute) for functions that change keys to avoid such issues.
  *   Keep enablement like this and disable the protection for the related fu=
nctions in trusted-services. We would like to avoid this solution due to comp=
atibility issues with other SPMC implementations.

My problem is that I do not understand the purpose of thread_core_local[n].ke=
ys and threads[n].keys, why are there two different key pairs? Is it a bug th=
at the original keys are not restored or is intentional like this?
Do you have an idea what would be the best solution for implementing this cha=
nge?

Thanks in advance!

G=C3=A1bor

--===============0902479194788789978==--

