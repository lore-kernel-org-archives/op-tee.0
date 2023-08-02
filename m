From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 3/5] efi: Add tee-based EFI variable driver
Date: Wed, 02 Aug 2023 11:50:22 +0900
Message-ID: 
 <CADQ0-X91QS8F1UA4Yzj8skk-q+F_5XaU=jQiew_TBpxV7=X5PA@mail.gmail.com>
In-Reply-To: <a6d9857c-fcbd-74d0-bc97-fc86a8c1b820@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4093966254459744596=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4093966254459744596==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Aug 2023 at 00:05, Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 7/30/23 23:50, Masahisa Kojima wrote:
> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > index 043ca31c114e..aa38089d1e4a 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -287,3 +287,18 @@ config UEFI_CPER_X86
> >       bool
> >       depends on UEFI_CPER && X86
> >       default y
> > +
> > +config TEE_STMM_EFI
> > +     tristate "TEE based EFI runtime variable service driver"
>
>                   TEE-based
OK.

>
> > +     depends on EFI && OPTEE && !EFI_VARS_PSTORE
> > +     help
> > +       Select this config option if TEE is compiled to include StandAlon=
eMM
> > +       as a separate secure partition it has the ability to check and st=
ore
>
>                                partition. It has the ability
OK.

Thank you for your review.

Regards,
Masahisa Kojima

>
> > +       EFI variables on an RPMB or any other non-volatile medium used by
> > +       StandAloneMM.
> > +
> > +       Enabling this will change the EFI runtime services from the firmw=
are
> > +       provided functions to TEE calls.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called tee_stmm_efi.
>
> --
> ~Randy

--===============4093966254459744596==--

