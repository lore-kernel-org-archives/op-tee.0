From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: OP-TEE Development Guidance
Date: Wed, 08 Jul 2020 17:26:43 +0200
Message-ID: 
 <CAHUa44Hp+D9a6ka2Ltvbf3DouOavFtNuFs5dEg-s5VXfJZ0__w@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3C01000172c6620313-7c8403bf-f8ec-4702-a98f-43e601f2d?=
 =?utf-8?q?d66-000000=40email=2Eamazonses=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4659587568351509598=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4659587568351509598==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Saad,

On Thu, Jun 18, 2020 at 9:43 AM Muhammad Saad via OP-TEE
<op-tee@lists.trustedfirmware.org> wrote:
>
> Hello All,
>
> First, I hope you are safe and doing fine in the unfortunate COVID-19 situa=
tion. I am a Ph.D. student at the University of Central Florida. Currently, I=
 am working on a TEE-based prototype application for a proof-of-concept. Sinc=
e I am totally new in this domain, so it is taking some effort. I have a few =
questions and I hope you guys can help me in that.
>
> At present, I am able to set up OP-TEE on Qemu and run the examples on the =
normal world and the secure world. Additionally, I tweaked a few parameters (=
ie., the integer value in the main.c) for the CA and the addition and subtrac=
tion sequence in the TA. Upon building it again (cd/build/make all run), it s=
eems to work. However, if I need to pass a normal string to the TA and the TA=
 computes Sha256 of the string and returns the value, what steps do I need to=
 take? In other words, how can I pass a tuple from the TA to the CA and obtai=
n the Hash of the tuple. Additionally, if I am able to do that by tailoring t=
he HelloWorld examples, how can I develop new CA and TA with unique UUID and =
perform the same procedure. Finally, instead of doing the entire (cd/build/ma=
ke all run), is there a method by which I can simply build the application an=
d alone and run it on Qemu?

You can find an example of doing some hashing at
https://github.com/OP-TEE/optee_test/blob/391168ec03980e1cc8fb6d3e3c4b424819c=
d90cf/host/xtest/regression_1000.c#L106

You'll need to look around a little to get the whole picture, but it
shouldn't be too hard.

If you only change a TA or some client application it's enough to rebuild wit=
h:
make buildroot

and then run it with:
make run-only

A new UUID can be obtained with the Linux command uuidgen.

Cheers,
Jens

>
> I understand that these must be trivial questions, however, I will deeply a=
ppreciate if you can help me in figuring them out.
>
>
> Best,
>
> Saad
> --
> OP-TEE mailing list
> OP-TEE(a)lists.trustedfirmware.org
> https://lists.trustedfirmware.org/mailman/listinfo/op-tee

--===============4659587568351509598==--

