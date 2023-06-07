From: Arnd Bergmann <arnd@arndb.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] AMDTEE fix for v6.5
Date: Wed, 07 Jun 2023 15:58:41 +0200
Message-ID: <3ef35dd4-0c05-4705-823f-85e96a5a9b99@app.fastmail.com>
In-Reply-To: <
 <CAHUa44E5RjMqeTp1Sr_7=Eavu3T+q2YVg-V-_gLWpO5sjJ-Vhg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0950159536248958584=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0950159536248958584==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, Jun 7, 2023, at 08:53, Jens Wiklander wrote:
> On Tue, Jun 6, 2023 at 1:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tue, Jun 6, 2023, at 09:58, Jens Wiklander wrote:
>> > Hello arm-soc maintainers,
>> >
>> > Please pull this AMDTEE driver fix to add a return origin field to the
>> > struct tee_cmd_load_ta used when loading a Trusted Application into the
>> > AMDTEE. This change is backward compatible.
>> >
>> > Note that this isn't a usual Arm driver update. This targets AMD instead,
>> > but is part of the TEE subsystem.
>> >
>>
>> I see there is only one patch here, and it is marked as 'Cc: stable',
>> so I assume  you meant this to be include in v6.4, not 6.5. Can you
>> confirm that?
>
> If you don't mind taking it for v6.4 that's even better.

Yes, done that now. 

       Arnd

--===============0950159536248958584==--

