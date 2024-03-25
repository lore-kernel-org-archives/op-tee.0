From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Mon, 25 Mar 2024 14:44:13 +0100
Message-ID: 
 <CAHUa44E7z=nppPnBEAqUddtrbTeiZxK8gQ95AGV9oA0-UdLMCQ@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CPH7PR11MB76054BC0C863E5947C7B2DAFE5362=40PH7PR11MB?=
 =?utf-8?q?7605=2Enamprd11=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1862014786355054720=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1862014786355054720==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 9:23=E2=80=AFAM Winkler, Tomas <tomas.winkler@intel=
.com> wrote:
>
>
> > > > +struct rpmb_frame {
> > > > +       u8     stuff[196];
> > > > +       u8     key_mac[32];
> > > > +       u8     data[256];
> > > > +       u8     nonce[16];
> > > > +       __be32 write_counter;
> > > > +       __be16 addr;
> > > > +       __be16 block_count;
> > > > +       __be16 result;
> > > > +       __be16 req_resp;
> > > > +} __packed;
> > >
> > > I haven't looked at the NVME or the UFS spec in detail. Although, I
> > > assume the above frame makes sense for those types of
> > interfaces/protocols too?
> > The rpmb implementation in ufs, has drifted apart from eMMC. E.g. in
> > UFS4.0:
> >  -  the frame is different - see struct ufs_arpmb_meta in
> > include/uapi/scsi/scsi_bsg_ufs.h,
> >  - Additional extended header was added,
> >  - the frame size is no longer 512Bytes (256Bytes meta info + 256Bytes da=
ta)
> > but 4k,
> >  - there are 9 rpmb operations instead of 7,
> >  - The atomicity requirement of the command sequence was waved, And
> > probably more differences that I forgot.
> > This is why it is better to designated this as an eMMC-only implementatio=
n?

Thanks for the update.

To move forward here we can either
1. as you suggest make this an eMMC-only implementation,
or
2. we could remove struct rpmb_frame from include/linux/rpmb.h to make
the shuffled data more opaque.

Is it possible to find and route RPMB data to NVME and UFS devices
without a common meeting point like the RPMB subsystem proposed here?
If the answer is yes option 1 makes more sense since we'll add a
missing capability to eMMC. If the answer is no option 2 makes sense
for NVME and UFS even if we save the implementation for later.

>
> As  I wrote previously the original implementation has already resolved pro=
tocol differences
>  (NVMe have also different byte ordering) for closed usecase of storing dat=
a (not the configuration)
> I believe the whole point here is to let TEE driver to store the data, rega=
rdless of the technology.

Agreed.

>  In addition I might be wrong but I don't see much value in eMMC as the UFS=
 and NVMe are currently leading technologies.

This patchset addresses a problem on present platforms so it's not irrelevant.

Thanks,
Jens

--===============1862014786355054720==--

