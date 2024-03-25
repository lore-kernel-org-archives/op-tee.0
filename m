From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 RE: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Mon, 25 Mar 2024 08:22:57 +0000
Message-ID: <PH7PR11MB76054BC0C863E5947C7B2DAFE5362@PH7PR11MB7605.namprd11.prod.outlook.com>
In-Reply-To: <=?utf-8?q?=3CDM6PR04MB65755A95AA492565F7576D10FC362=40DM6PR04MB?=
 =?utf-8?q?6575=2Enamprd04=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8796876543314900395=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8796876543314900395==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


> > > +struct rpmb_frame {
> > > +       u8     stuff[196];
> > > +       u8     key_mac[32];
> > > +       u8     data[256];
> > > +       u8     nonce[16];
> > > +       __be32 write_counter;
> > > +       __be16 addr;
> > > +       __be16 block_count;
> > > +       __be16 result;
> > > +       __be16 req_resp;
> > > +} __packed;
> >
> > I haven't looked at the NVME or the UFS spec in detail. Although, I
> > assume the above frame makes sense for those types of
> interfaces/protocols too?
> The rpmb implementation in ufs, has drifted apart from eMMC. E.g. in
> UFS4.0:
>  -  the frame is different - see struct ufs_arpmb_meta in
> include/uapi/scsi/scsi_bsg_ufs.h,
>  - Additional extended header was added,
>  - the frame size is no longer 512Bytes (256Bytes meta info + 256Bytes data)
> but 4k,
>  - there are 9 rpmb operations instead of 7,
>  - The atomicity requirement of the command sequence was waved, And
> probably more differences that I forgot.
> This is why it is better to designated this as an eMMC-only implementation?

As  I wrote previously the original implementation has already resolved proto=
col differences
 (NVMe have also different byte ordering) for closed usecase of storing data =
(not the configuration) =20
I believe the whole point here is to let TEE driver to store the data, regard=
less of the technology.=20
 In addition I might be wrong but I don't see much value in eMMC as the UFS a=
nd NVMe are currently leading technologies.=20
Thanks
Tomas


--===============8796876543314900395==--

