From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Secure Storage Applications
Date: Wed, 23 Feb 2022 11:37:33 +0530
Message-ID: 
 <CAFA6WYMYzz__4nBgjcF4hcdMPLai8qkVa0g29nyHL3h+cNLvLw@mail.gmail.com>
In-Reply-To: <20220222090859.er2hnumy52akeint@ula0497581>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9121673867535655992=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9121673867535655992==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Manorit,

On Tue, 22 Feb 2022 at 18:59, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
>
> Hi,
>
> I have been exploring secure storage in OP-TEE for a few days and I need
> some help in putting some files into it.
>
> I have been trying to find some tool which could help me put any files from
> Linux into secure storage and retrieve them back later so that I could
> see secure storage in action but haven't been able to find any yet.
>
> Is there any tool which you guys might know of which helps put files in
> secure storage and retrieve them back later?
>

I would suggest you have a look at storage tests from OP-TEE test
suite here: client  [1] and TA [2].

[1] https://github.com/OP-TEE/optee_test/blob/master/host/xtest/regression_60=
00.c
[2] https://github.com/OP-TEE/optee_test/tree/master/ta/storage

-Sumit

> Best Regards,
> Manorit

--===============9121673867535655992==--

