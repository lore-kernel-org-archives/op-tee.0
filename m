From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 0/5] introduce tee-based EFI Runtime Variable Service
Date: Thu, 17 Aug 2023 12:33:17 +0300
Message-ID: 
 <CAC_iWjJ5Sw8YtLYnqaJfwrqsrV3vAKv0VHYL2uyGxttsg-TNHQ@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYMekJC8dOUU-d7DJDK6fiUh27sWw8xbVMvFGmBe8VYxLA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5354544665224476701=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5354544665224476701==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Aug 2023 at 12:22, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Wed, 16 Aug 2023 at 19:37, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >
> > On 16.08.23 13:58, Ilias Apalodimas wrote:
> > > On Tue, 15 Aug 2023 at 05:41, Masahisa Kojima
> > > <masahisa.kojima@linaro.org> wrote:
> > >>
> > >> Hi Jan,
> > >>
> > >> 2023=E5=B9=B48=E6=9C=8815=E6=97=A5(=E7=81=AB) 2:23 Jan Kiszka <jan.kis=
zka@siemens.com>:
> > >>>
> > >>> On 14.08.23 11:24, Ilias Apalodimas wrote:
> > >>>> Hi Jan,
> > >>>>
> > >>>> On Mon, 7 Aug 2023 at 05:53, Masahisa Kojima <masahisa.kojima@lina=
ro.org> wrote:
> > >>>>>
> > >>>>> This series introduces the tee based EFI Runtime Variable Service.
> > >>>>>
> > >>>>> The eMMC device is typically owned by the non-secure world(linux in
> > >>>>> this case). There is an existing solution utilizing eMMC RPMB parti=
tion
> > >>>>> for EFI Variables, it is implemented by interacting with
> > >>>>> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> > >>>>> and tee-supplicant. The last piece is the tee-based variable access
> > >>>>> driver to interact with OP-TEE and StandaloneMM.
> > >>>>>
> > >>>>> Changelog:
> > >>>>> v7 -> v8
> > >>>>> Only patch #3 "efi: Add tee-based EFI variable driver" is updated.
> > >>>>> - fix typos
> > >>>>> - refactor error handling, direct return if applicable
> > >>>>> - use devm_add_action_or_reset() for closing of tee context/session
> > >>>>> - remove obvious comment
> > >>>>
> > >>>> Any chance you can run this and see if it solves your issues?
> > >>>>
> > >>>
> > >>> I also need [1], and I still need a cleanup script before terminating
> > >>> the tee-supplicant, right?
> > >>
> > >>
> > >> Yes, we need patch[1] and a cleanup script.
> > >> Sorry, I should note in the cover letter.
> > >>
> > >>> And if need some service in the initrd
> > >>> already, I still need to start the supplicant there and transfer its
> > >>> ownership to systemd later on?
> > >>
> > >> Yes.
> > >>
> > >>> These patches here only make life easier
> > >>> if the supplicant is started by systemd, after efivarfs has been
> > >>> mounted, correct?
> > >
> > > Not systemd specifically.  Any tool that can signal
> > > <dev>/driver/unbind would work.  Sumit is just reusing the default
> > > unbind notification mechanism
> > >
> >
> > I was referring to the boot ordering topic, not the shutdown issue.
> >
> > The latter has now a nicer way to trigger the device shutdown prior to
> > killing tee-supplicant, but you still need to do that explicitly, no?
> >
>
> Yeah it has to be done explicitly in user-space. As you have already
> seen, my first try (v1 patch) to do it in kernel space failed. The
> reason being that when those devices are being removed, the
> tee-supplicant has to be alive to handle RPC calls. The kernel only
> gets notified once "/dev/teepriv0" fd is closed and by that time
> tee-supplicant is already dead.

Yea, that was along the lines of what I asked in a past mail.  IOW
bind the cleanups needed on the opening/closing of the
"/dev/teepriv0", but unfortunately that's not doable.  What we could
do as a future enhancement is add a signal handler in the supplicant
that signals the events without relying on a different userspace app
to do that.

Sumit pointed out a few things we need to be cautious about on the
signal handler, but in any case, that's orthogonal to the current
approach.

Thanks
/Ilias

>
> -Sumit
>
> > Jan
> >
> > --
> > Siemens AG, Technology
> > Linux Expert Center
> >

--===============5354544665224476701==--

