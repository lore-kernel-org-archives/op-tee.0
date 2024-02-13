From: Ulf Hansson <ulf.hansson@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Wed, 14 Feb 2024 00:16:05 +0100
Message-ID: 
 <CAPDyKFr3QfDOhXkXQ7PTBDBviepQZsv05UmOiw=cn-QbS+xsnA@mail.gmail.com>
In-Reply-To: <
 <CAHUa44Ht93U2Q78Xx91J_Xq=dBrhwjy2tERO4BntfNywewxVAg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2965169025218521410=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2965169025218521410==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Feb 2024 at 09:06, Jens Wiklander <jens.wiklander@linaro.org> wro=
te:
>
> On Tue, Feb 6, 2024 at 1:34=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> >
> > On Wed, 31 Jan 2024 at 18:44, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > A number of storage technologies support a specialised hardware
> > > partition designed to be resistant to replay attacks. The underlying
> > > HW protocols differ but the operations are common. The RPMB partition
> > > cannot be accessed via standard block layer, but by a set of specific
> > > RPMB commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> > > partition provides authenticated and replay protected access, hence
> > > suitable as a secure storage.
> > >
> > > The initial aim of this patch is to provide a simple RPMB Driver which
> > > can be accessed by the optee driver to facilitate early RPMB access to
> > > OP-TEE OS (secure OS) during the boot time.
> >
> > How early do we expect OP-TEE to need RPMB access?
> >
> > The way things work for mmc today, is that the eMMC card gets
> > discovered/probed via a workqueue. The work is punted by the mmc host
> > driver (typically a module-platform-driver), when it has probed
> > successfully.
> >
> > The point is, it looks like we need some kind of probe deferral
> > mechanism too. Whether we want the OP-TEE driver to manage this itself
> > or whether we should let rpmb_dev_find_device() deal with it, I don't
> > know.
>
> As I wrote in another reply. I'd like to probe the OP-TEE driver
> without touching RPMB first, and then as the devices start to appear
> we discover the one to use. In this patchset I'm relying on the OP-TEE
> client to wait until the RPMB device is available. That's probably
> good enough for user space client, but I guess not for kernel clients
> (drivers).

Right, I understand.

Obviously we don't need to solve all problems (use-cases) at once, but
it sure sounds like we at least need to make some additional thinking
around this part.

>
> >
> > >
> > > A TEE device driver can claim the RPMB interface, for example, via
> > > class_interface_register() or rpmb_dev_find_device(). The RPMB driver
> > > provides a callback to route RPMB frames to the RPMB device accessible
> > > via rpmb_route_frames().
> >
> > By looking at the design of the interface, I do like it. It's simple
> > and straightforward.
> >
> > However, I wonder if you considered avoiding using a class-device
> > altogether? Even if it helps with lifecycle problems and the
> > ops-lookup, we really don't need another struct device with a sysfs
> > node, etc.
>
> Yes, the class-device might be more of a leftover from earlier
> versions with a user space interface too. Let's try to do this without
> a class-device. I was considering using class_interface_register() for
> the optee driver to get notified of an eventual RPMB device, but if we
> don't have an RPMB class device we'll need some other mechanism for
> that. Perhaps a rpmb_interface_register() with similar callbacks as
> class_interface_register().

Okay, sounds like you want to make it a try. I am happy to look at the
code, ofcourse. Although, honestly - I don't know what's the preferred
option here.

>
> >
> > To deal with the lifecycle issue, we could probably just add reference
> > counting for the corresponding struct device that we already have at
> > hand, which represents the eMMC/UFS/NVME card. That together with a
> > simple list that contains the registered rpmb ops. But I may be
> > overlooking something, so perhaps it's more complicated than that?
>
> I could try to call mmc_blk_get() in mmc_blk_alloc_rpmb_part() when
> storing the md pointer in the newly created struct mmc_rpmb_data. If
> that works as I hope, then I can get rid of the two get_resources()
> and put_resources() callbacks. We should probably update
> mmc_rpmb_chrdev_open() and mmc_rpmb_chrdev_release() to match this.

Something like that. But I need to have a closer look at this
(probably easier to review another version of the patchseries), to
really tell what works best.

Do note that mmc/sd cards are hot-pluggable (removable) from the mmc
block device point of view.

[...]

Kind regards
Uffe

--===============2965169025218521410==--

