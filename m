From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [Tee-dev] Persistent filesystem between reboots
Date: Fri, 15 Jan 2021 13:50:10 +0100
Message-ID: 
 <CAHUa44GAOo1C=C+Vp_=vaZg3-RcrO-_UnToNgtX2bQFv4HXaUg@mail.gmail.com>
In-Reply-To: <711a871a-ca56-38c9-9134-c438d2c17878@amongbytes.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9042621149018125110=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9042621149018125110==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Kris,

On Thu, Jan 14, 2021 at 1:37 PM Kris Kwiatkowski <kris@amongbytes.com> wrot=
e:
>
> Hi,
>
> I'm using HiKey 960 for my research project. I've noticed that
> filesystem is not persistent between reboot. Is there a way
> to change it, so that any change to file in the /etc will be
> persistent?

There's no easy way of doing that with our repo based builds I'm aware
of. The purpose of our (OP-TEE team) builds is in principle to be able
to execute xtest and other test programs. For this use case it's
actually an advantage to start from a clean state each time. In your
case I think you need to pick a suitable distribution and update it as
needed to support OP-TEE. It could be worth looking at Yocto as there
is some OP-TEE support already.

Here's a short list of what's needed:
1. TF-A compiled with OP-TEE support (dispatcher in BL31 and load
support in bl2)
2. OP-TEE included in the FIP loaded by TF-A
3. OP-TEE nodes in device tree
4. OP-TEE driver enabled in the kernel (recent upstream kernel should
work in most cases)
5. tee-supplicant and libteec.so installed in the file system
6. tee-supplicant started

With that in place you should be good to go.

Cheers,
Jens

--===============9042621149018125110==--

