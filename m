From: Ard Biesheuvel <ardb@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/3] introduce tee-based EFI Runtime Variable Service
Date: Thu, 25 May 2023 18:11:14 +0200
Message-ID: 
 <CAMj1kXGxTcsWxwKayf8YDy_iocPJu2reWgMBtRfs8ZNin4fPpg@mail.gmail.com>
In-Reply-To: <
 <CAC_iWjKxXrEgpqgnpt8g0ummdb1mFbwgMVTSVqfRTNbXOwhz2w@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6811871939933604693=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6811871939933604693==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 May 2023 at 10:01, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sumit,
>
> On Wed, 24 May 2023 at 10:56, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > On Tue, 23 May 2023 at 14:36, Masahisa Kojima
> > <masahisa.kojima@linaro.org> wrote:
> > >
> > > This series introduces the tee based EFI Runtime Variable Service.
> > >
> > > The eMMC device is typically owned by the non-secure world(linux in
> > > this case). There is an existing solution utilizing eMMC RPMB partition
> > > for EFI Variables, it is implemented by interacting with
> > > OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> > > and tee-supplicant. The last piece is the tee-based variable access
> > > driver to interact with OP-TEE and StandaloneMM.
> > >
> > > Changelog:
> > > v3 -> v4:
> > > - replace the reference from EDK2 to PI Specification
> > > - remove EDK2 source code reference comments
> > > - prepare nonblocking variant of set_variable, it just returns
> > >   EFI_UNSUPPORTED
> > > - remove redundant buffer size check
> > > - argument name change in mm_communicate
> > > - function interface changes in setup_mm_hdr to remove (void **) cast
> >
> > I don't have detailed insights into how EFI spec mandates StandaloneMM
> > should be implemented. But utilizing OP-TEE as the underlying
> > transport here looks fine to me. FWIW,
> >
> > For the series:
> > Acked-by: Sumit Garg <sumit.garg@linaro.org>
>
> Thanks!
>
>  FWIW the PI spec describes some of the functionality and how that
> should be accessed.
> There's a EFI_MM_COMMUNICATION_PROTOCOL which is not used here.
> Instead the entry point is via an SMC to op-tee and the payload
> adheres to what the PI spec describes in its EFI_MM_COMMUNICATE_HEADER
>

Thanks for the resend

Could you please double check whether this needs any changes in
relation to this patch?

https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?id=3Dd86f=
f3333cb1d5f4

--===============6811871939933604693==--

