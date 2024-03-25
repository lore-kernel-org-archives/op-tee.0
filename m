From: Avri Altman <Avri.Altman@wdc.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 RE: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Mon, 25 Mar 2024 08:07:55 +0000
Message-ID: <DM6PR04MB65755A95AA492565F7576D10FC362@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <
 <CAPDyKFp5j+L=oE1uVyUdu7rVLxRcueWwP0XcNTTMMrFQgmeZiw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9093023381137223183=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9093023381137223183==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> > +struct rpmb_frame {
> > +       u8     stuff[196];
> > +       u8     key_mac[32];
> > +       u8     data[256];
> > +       u8     nonce[16];
> > +       __be32 write_counter;
> > +       __be16 addr;
> > +       __be16 block_count;
> > +       __be16 result;
> > +       __be16 req_resp;
> > +} __packed;
>=20
> I haven't looked at the NVME or the UFS spec in detail. Although, I assume =
the
> above frame makes sense for those types of interfaces/protocols too?
The rpmb implementation in ufs, has drifted apart from eMMC. E.g. in UFS4.0:
 -  the frame is different - see struct ufs_arpmb_meta in include/uapi/scsi/s=
csi_bsg_ufs.h,
 - Additional extended header was added,
 - the frame size is no longer 512Bytes (256Bytes meta info + 256Bytes data) =
but 4k,
 - there are 9 rpmb operations instead of 7,=20
 - The atomicity requirement of the command sequence was waved,
And probably more differences that I forgot.
This is why it is better to designated this as an eMMC-only implementation?

Thanks,
Avri


--===============9093023381137223183==--

