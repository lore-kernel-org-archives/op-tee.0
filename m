From: Souptick Joarder <jrdr.linux@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee/tee_shm.c: Fix error handling path
Date: Sun, 13 Sep 2020 18:31:08 +0530
Message-ID: 
 <CAFqt6zYA4srnsGx+OzrzVuzasOvUQR+dN0nmVZcv1zVeotxKUA@mail.gmail.com>
In-Reply-To: <641dfe3b-1de8-97ea-eac7-89d81846eab3@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4647026224130096188=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4647026224130096188==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2020 at 2:00 PM Markus Elfring <Markus.Elfring@web.de> wrot=
e:
>
> > When shm->num_pages <=3D 0, we should avoid calling
> > release_registered_pages() in error handling path.
>
> * Would an imperative wording become helpful for the change description?
>
> * I suggest to add the tag =E2=80=9CFixes=E2=80=9D to the commit message.

Sure. Will address both in v2.
>
> Regards,
> Markus

--===============4647026224130096188==--

