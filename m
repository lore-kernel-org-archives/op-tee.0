From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 0/5] introduce tee-based EFI Runtime Variable Service
Date: Tue, 15 Aug 2023 11:40:49 +0900
Message-ID: 
 <CADQ0-X_dJag7EuEEEgCZrnJNNH9Va77mxmGYA9vPFw9DkoB-AA@mail.gmail.com>
In-Reply-To: <660cec45-d0d1-433f-b58e-a22a07a289fb@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0656208766575004889=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0656208766575004889==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

2023=E5=B9=B48=E6=9C=8815=E6=97=A5(=E7=81=AB) 2:23 Jan Kiszka <jan.kiszka@s=
iemens.com>:

> On 14.08.23 11:24, Ilias Apalodimas wrote:
> > Hi Jan,
> >
> > On Mon, 7 Aug 2023 at 05:53, Masahisa Kojima <masahisa.kojima@linaro.or=
g>
> wrote:
> >>
> >> This series introduces the tee based EFI Runtime Variable Service.
> >>
> >> The eMMC device is typically owned by the non-secure world(linux in
> >> this case). There is an existing solution utilizing eMMC RPMB partition
> >> for EFI Variables, it is implemented by interacting with
> >> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> >> and tee-supplicant. The last piece is the tee-based variable access
> >> driver to interact with OP-TEE and StandaloneMM.
> >>
> >> Changelog:
> >> v7 -> v8
> >> Only patch #3 "efi: Add tee-based EFI variable driver" is updated.
> >> - fix typos
> >> - refactor error handling, direct return if applicable
> >> - use devm_add_action_or_reset() for closing of tee context/session
> >> - remove obvious comment
> >
> > Any chance you can run this and see if it solves your issues?
> >
>
> I also need [1], and I still need a cleanup script before terminating
> the tee-supplicant, right?


Yes, we need patch[1] and a cleanup script.
Sorry, I should note in the cover letter.

And if need some service in the initrd
> already, I still need to start the supplicant there and transfer its
> ownership to systemd later on?

Yes.

These patches here only make life easier
> if the supplicant is started by systemd, after efivarfs has been
> mounted, correct?

Yes.

Thanks,
Masahisa Kojima


>
> Jan
>
> [1] https://lkml.org/lkml/2023/7/28/853
>
> --
> Siemens AG, Technology
> Linux Expert Center
>
>

--===============0656208766575004889==--

