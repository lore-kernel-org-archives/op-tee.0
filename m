From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 0/5] introduce tee-based EFI Runtime Variable Service
Date: Thu, 17 Aug 2023 14:52:46 +0530
Message-ID: 
 <CAFA6WYMekJC8dOUU-d7DJDK6fiUh27sWw8xbVMvFGmBe8VYxLA@mail.gmail.com>
In-Reply-To: <1fd4b729-3896-48b6-865e-85b4f1ba5ee9@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1331687975349871723=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1331687975349871723==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Aug 2023 at 19:37, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 16.08.23 13:58, Ilias Apalodimas wrote:
> > On Tue, 15 Aug 2023 at 05:41, Masahisa Kojima
> > <masahisa.kojima@linaro.org> wrote:
> >>
> >> Hi Jan,
> >>
> >> 2023=E5=B9=B48=E6=9C=8815=E6=97=A5(=E7=81=AB) 2:23 Jan Kiszka <jan.kiszk=
a@siemens.com>:
> >>>
> >>> On 14.08.23 11:24, Ilias Apalodimas wrote:
> >>>> Hi Jan,
> >>>>
> >>>> On Mon, 7 Aug 2023 at 05:53, Masahisa Kojima <masahisa.kojima@linaro=
.org> wrote:
> >>>>>
> >>>>> This series introduces the tee based EFI Runtime Variable Service.
> >>>>>
> >>>>> The eMMC device is typically owned by the non-secure world(linux in
> >>>>> this case). There is an existing solution utilizing eMMC RPMB partiti=
on
> >>>>> for EFI Variables, it is implemented by interacting with
> >>>>> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> >>>>> and tee-supplicant. The last piece is the tee-based variable access
> >>>>> driver to interact with OP-TEE and StandaloneMM.
> >>>>>
> >>>>> Changelog:
> >>>>> v7 -> v8
> >>>>> Only patch #3 "efi: Add tee-based EFI variable driver" is updated.
> >>>>> - fix typos
> >>>>> - refactor error handling, direct return if applicable
> >>>>> - use devm_add_action_or_reset() for closing of tee context/session
> >>>>> - remove obvious comment
> >>>>
> >>>> Any chance you can run this and see if it solves your issues?
> >>>>
> >>>
> >>> I also need [1], and I still need a cleanup script before terminating
> >>> the tee-supplicant, right?
> >>
> >>
> >> Yes, we need patch[1] and a cleanup script.
> >> Sorry, I should note in the cover letter.
> >>
> >>> And if need some service in the initrd
> >>> already, I still need to start the supplicant there and transfer its
> >>> ownership to systemd later on?
> >>
> >> Yes.
> >>
> >>> These patches here only make life easier
> >>> if the supplicant is started by systemd, after efivarfs has been
> >>> mounted, correct?
> >
> > Not systemd specifically.  Any tool that can signal
> > <dev>/driver/unbind would work.  Sumit is just reusing the default
> > unbind notification mechanism
> >
>
> I was referring to the boot ordering topic, not the shutdown issue.
>
> The latter has now a nicer way to trigger the device shutdown prior to
> killing tee-supplicant, but you still need to do that explicitly, no?
>

Yeah it has to be done explicitly in user-space. As you have already
seen, my first try (v1 patch) to do it in kernel space failed. The
reason being that when those devices are being removed, the
tee-supplicant has to be alive to handle RPC calls. The kernel only
gets notified once "/dev/teepriv0" fd is closed and by that time
tee-supplicant is already dead.

-Sumit

> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center
>

--===============1331687975349871723==--

