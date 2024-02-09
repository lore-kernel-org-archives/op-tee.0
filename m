From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Why UBSAN is marked as using a lot of memory?
Date: Fri, 09 Feb 2024 14:01:08 +0100
Message-ID: 
 <CAHUa44Etp05V+Cdck9ch+Z4-kYHUiHZNiV6M7VOoB=VzH=+NmQ@mail.gmail.com>
In-Reply-To: <
 <CAEUiM9N4z+btycMir_Mgr1JgqxmhLhkeuh=FheB+ENyjmydeoA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3294743100707891299=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3294743100707891299==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Igor,

On Fri, Feb 9, 2024 at 1:49=E2=80=AFPM Igor Zhbanov <izh1979@gmail.com> wro=
te:
>
> Hi Jens,
>
> Fri, 9 Feb. 2024=E2=80=AF=D0=B3. =D0=B2 14:33, Jens Wiklander <jens.wikland=
er@linaro.org>:
>>
>> Hi Igor,
>>
>> On Mon, Feb 5, 2024 at 5:45=E2=80=AFPM Igor Zhbanov <izh1979@gmail.com> =
wrote:
>>
>> > So, I suppose that the overhead for OP-TEE should also be small, as there
>> > is no detailed
>> > error logging. But, of course, it is better to be tested.
>>
>> I guess that depends on what you mean by detailed, it prints file
>> name, line, and column when logging.
>
>
> I hoped, it is possible to run UBSAN in minimalistic mode, where it would j=
ust print the current IP
> of violation instruction (and optionally reset the device). Then the overhe=
ad should be acceptable.

Sure, that should be possible.

Cheers,
Jens

--===============3294743100707891299==--

