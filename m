From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: OP-TEE Development Guidance
Date: Fri, 10 Jul 2020 11:46:04 +0200
Message-ID: 
 <CAHUa44Ei8_EDfzfOJPUqaGzTXA-Q1CbnUDyLzk8LGbqp6GRaFA@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CBL0PR07MB5524D5F4D5B8EB5DCCE86892D3670=40BL0PR07MB?=
 =?utf-8?q?5524=2Enamprd07=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4830532457088789800=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4830532457088789800==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2020 at 7:56 PM Muhammad Saad <saad.ucf@knights.ucf.edu> wro=
te:
>
> Hi Jens,
>
> I was able to do all those operations last week. I actually cloned a pseudo=
-TA, assign it a new UUID, and do all the required cryptographic operations a=
s well as the secure storage.  However, now that I try to benchmark it, an er=
ror is thrown ([Benchmark] ERROR: TEEC_InvokeCommand: 0xffff000c). Can you te=
ll me the right way of benchmarking a pseudo-TA? Also, if I want to take all =
the pseduo-TA code and make a new TA, what should be the simplest process?

I suggest that you start out with studying
https://optee.readthedocs.io/en/latest/ it will probably answer your
questions and give a good overview too.

Cheers,
Jens

>
> Best,
>
> Saad
>
> ________________________________
> From: Jens Wiklander <jens.wiklander@linaro.org>
> Sent: Wednesday, July 8, 2020 11:26 AM
> To: Muhammad Saad <saad.ucf@Knights.ucf.edu>
> Cc: op-tee(a)lists.trustedfirmware.org <op-tee@lists.trustedfirmware.org>
> Subject: Re: OP-TEE Development Guidance
>
> Hi Saad,
>
> On Thu, Jun 18, 2020 at 9:43 AM Muhammad Saad via OP-TEE
> <op-tee@lists.trustedfirmware.org> wrote:
> >
> > Hello All,
> >
> > First, I hope you are safe and doing fine in the unfortunate COVID-19 sit=
uation. I am a Ph.D. student at the University of Central Florida. Currently,=
 I am working on a TEE-based prototype application for a proof-of-concept. Si=
nce I am totally new in this domain, so it is taking some effort. I have a fe=
w questions and I hope you guys can help me in that.
> >
> > At present, I am able to set up OP-TEE on Qemu and run the examples on th=
e normal world and the secure world. Additionally, I tweaked a few parameters=
 (ie., the integer value in the main.c) for the CA and the addition and subtr=
action sequence in the TA. Upon building it again (cd/build/make all run), it=
 seems to work. However, if I need to pass a normal string to the TA and the =
TA computes Sha256 of the string and returns the value, what steps do I need =
to take? In other words, how can I pass a tuple from the TA to the CA and obt=
ain the Hash of the tuple. Additionally, if I am able to do that by tailoring=
 the HelloWorld examples, how can I develop new CA and TA with unique UUID an=
d perform the same procedure. Finally, instead of doing the entire (cd/build/=
make all run), is there a method by which I can simply build the application =
and alone and run it on Qemu?
>
> You can find an example of doing some hashing at
> https://nam02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.=
com%2FOP-TEE%2Foptee_test%2Fblob%2F391168ec03980e1cc8fb6d3e3c4b424819cd90cf%2=
Fhost%2Fxtest%2Fregression_1000.c%23L106&amp;data=3D02%7C01%7Csaad.ucf%40knig=
hts.ucf.edu%7C078dff5cf5884ef2466308d8235358b9%7C5b16e18278b3412c919668342689=
eeb7%7C0%7C1%7C637298188166072848&amp;sdata=3Df0th70K5qfcGs7lKwxkACJXE3YhFW63=
RqDAU6oG40zU%3D&amp;reserved=3D0
>
> You'll need to look around a little to get the whole picture, but it
> shouldn't be too hard.
>
> If you only change a TA or some client application it's enough to rebuild w=
ith:
> make buildroot
>
> and then run it with:
> make run-only
>
> A new UUID can be obtained with the Linux command uuidgen.
>
> Cheers,
> Jens
>
> >
> > I understand that these must be trivial questions, however, I will deeply=
 appreciate if you can help me in figuring them out.
> >
> >
> > Best,
> >
> > Saad
> > --
> > OP-TEE mailing list
> > OP-TEE(a)lists.trustedfirmware.org
> > https://nam02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.trustedfirmware.org%2Fmailman%2Flistinfo%2Fop-tee&amp;data=3D02%7C01%7Csaad.=
ucf%40knights.ucf.edu%7C078dff5cf5884ef2466308d8235358b9%7C5b16e18278b3412c91=
9668342689eeb7%7C0%7C1%7C637298188166072848&amp;sdata=3DJzi3jCUz6f0Hnw%2BZpsm=
J24LIwfDT17xQtu8okvtbvXM%3D&amp;reserved=3D0

--===============4830532457088789800==--

