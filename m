From: Ira Weiny <ira.weiny@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
Date: Thu, 06 Oct 2022 11:19:07 -0700
Message-ID: <Yz8cG6OAXvK48vc/@iweiny-desk3>
In-Reply-To: <
 <CAFA6WYMT9S1Di6DN_UXc823f0ZTkqerE1PB=oG6wmfx28vEbDg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2669655533259097176=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2669655533259097176==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 06, 2022 at 11:53:55AM +0530, Sumit Garg wrote:
> Hi Phil,
>=20
> Please don't top-post in the OSS mailing list.
>=20
> On Wed, 5 Oct 2022 at 08:59, Phil Chang (=E5=BC=B5=E4=B8=96=E5=8B=B3) <Phil=
.Chang@mediatek.com> wrote:
> >
> > Hi Sumit
> >
> > Thanks for mentioning that, in fact, our product is low memory devices, a=
nd continuous pages are extremely valuable.
> > Although our driver is not upstream yet but highly dependent on tee shm v=
malloc support,
>=20
> Sorry but you need to get your driver mainline in order to support
> vmalloc interface. As otherwise it's a maintenance nightmare to
> support interfaces in the mainline for out-of-tree drivers.

I agree.  It sounds like this driver is not going to be submitted any time
soon.  So I'll respin this series as is.  But I do have a couple of other
things to deal with first.  So if I'm wrong let me know soon.

Thanks,
Ira

--===============2669655533259097176==--

