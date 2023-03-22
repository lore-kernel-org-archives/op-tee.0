From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [Hafnium] Boot arguments for S-EL1 with SPMC at S-EL2
Date: Wed, 22 Mar 2023 10:32:59 +0100
Message-ID: 
 <CAHUa44Gh4WT78MDh7Qft-Bwxsf=wOiVwZmfdOa4+k2sUpx=xFQ@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CDB9PR08MB6796BA639A087CC0F501B8969B819=40DB9PR08MB?=
 =?utf-8?q?6796=2Eeurprd08=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0550759221809483447=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0550759221809483447==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Olivier,

Comments below.

On Tue, Mar 21, 2023 at 3:36=E2=80=AFPM Olivier Deprez <Olivier.Deprez@arm.=
com> wrote:
>
> Hi Jens,
>
> See comments inline [OD].
>
> Regards,
> Olivier.
>
>
> ________________________________
> From: Jens Wiklander via Hafnium <hafnium@lists.trustedfirmware.org>
> Sent: 21 March 2023 09:30
> To: Olivier Deprez <Olivier.Deprez@arm.com>
> Cc: hafnium(a)lists.trustedfirmware.org <hafnium@lists.trustedfirmware.or=
g>; OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
> Subject: [Hafnium] Boot arguments for S-EL1 with SPMC at S-EL2
>
> Hi Olivier,
>
> I'm trying to implement a relocatable OP-TEE binary so it can be
> loaded at different physical addresses without the need to recompile
> it. This means that in the case with Hafnium when changing
> "load-address" or "entrypoint-offset" in the OP-TEE SP manifest
> there's no need to recompile OP-TEE. For this to work OP-TEE must be
> able to figure out which memory range it's supposed to reside in.
>
> [OD] Fair enough, I believe that would conflate into some generic PIE suppo=
rt?
> I can see how this helps with the multi OP-TEE instances use case, perhaps?

Yes, it should help with that too.

>
> Currently, OP-TEE knows the entry point address from PC and "memory
> size" from X0. However, the "memory size" is from the "load-address"
> so "entrypoint-offset" must be subtracted from PC in order to know the
> allocated memory range.
>
> Do you have ideas on how OP-TEE at runtime can determine the allocated
> memory range?
>
> [OD] The standard way would be to use the FF-A boot protocol e.g. if you ad=
d this to OP-TEE's SP manifest:
> +       /* Boot protocol */
> +       gp-register-num =3D <0x0>;
> +
> +       /* Boot Info */
> +       boot-info {
> +               compatible =3D "arm,ffa-manifest-boot-info";
> +               ffa_manifest;
> +       };

Great! That does the trick.

Thanks,
Jens

>
> See https://trustedfirmware-a.readthedocs.io/en/latest/components/secure-pa=
rtition-manager.html#passing-boot-data-to-the-sp
> At SP entry, x0 contains the address of a 'Boot Information Blob' (FF-A v1.=
1 REL0 section 5.4.2) starting with a Boot Information Header (Table 5.9).
> The SP manifest DT address can be extracted from a Boot Information Descrip=
tor (Table 5.8).
> Eventually the SP is able to parse its own SP manifest, into which it finds=
 FF-A standard fields (load-address...) in addition to any impdef field added.
> Note the partition size is not standarded (it should probably be), so for s=
tarters you can add your own memsize field.
> There is some sample usage in TF-a-tests:
> https://git.trustedfirmware.org/TF-A/tf-a-tests.git/tree/spm/cactus/cactus_=
main.c#n146
> and also in context of EDKII/StMM:
> https://github.com/odeprez/edk2/commit/7066c913cb227056d68ea99de5e92f2067fe=
787e
>
>
> Thanks,
> Jens
> --
> Hafnium mailing list -- hafnium(a)lists.trustedfirmware.org
> To unsubscribe send an email to hafnium-leave(a)lists.trustedfirmware.org

--===============0550759221809483447==--

