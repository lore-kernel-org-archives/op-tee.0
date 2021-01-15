From: Joakim Bech <joakim.bech@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [Tee-dev] Persistent filesystem between reboots
Date: Fri, 15 Jan 2021 13:59:22 +0100
Message-ID: <20210115125922.GA27568@goby>
In-Reply-To: <=?utf-8?q?=3C010001770618d8b0-113c86a5-4a8d-4b41-85eb-1c4559a4a?=
 =?utf-8?q?889-000000=40email=2Eamazonses=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0448808811679076750=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0448808811679076750==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 15, 2021 at 12:50:27PM +0000, Jens Wiklander via OP-TEE wrote:
> Hi Kris,
>=20
> On Thu, Jan 14, 2021 at 1:37 PM Kris Kwiatkowski <kris@amongbytes.com> wr=
ote:
> >
> > Hi,
> >
> > I'm using HiKey 960 for my research project. I've noticed that
> > filesystem is not persistent between reboot. Is there a way
> > to change it, so that any change to file in the /etc will be
> > persistent?
>=20
> There's no easy way of doing that with our repo based builds I'm aware
> of. The purpose of our (OP-TEE team) builds is in principle to be able
> to execute xtest and other test programs. For this use case it's
> actually an advantage to start from a clean state each time. In your
> case I think you need to pick a suitable distribution and update it as
> needed to support OP-TEE. It could be worth looking at Yocto as there
> is some OP-TEE support already.
>=20
You can also give NFS a try, I tend to use that myself when playing with
OP-TEE and Raspberry Pi3. I.e., I basically just untar the rootfs
created by our setup into a folder that is exposed via NFS. Then in
addition to that I have a couple of helper scripts that copies the files
Jens mentioned below into that NFS folder when I need to update with
changed files (TA's, OP-TEE libs etc).

> Here's a short list of what's needed:
> 1. TF-A compiled with OP-TEE support (dispatcher in BL31 and load
> support in bl2)
> 2. OP-TEE included in the FIP loaded by TF-A
> 3. OP-TEE nodes in device tree
> 4. OP-TEE driver enabled in the kernel (recent upstream kernel should
> work in most cases)
> 5. tee-supplicant and libteec.so installed in the file system
> 6. tee-supplicant started
>=20
> With that in place you should be good to go.
>=20
> Cheers,
> Jens

--=20
Regards,
Joakim

--===============0448808811679076750==--

