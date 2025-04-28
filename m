From: Mario Limonciello <superm1@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 0/2] small amdtee cleanups
Date: Mon, 28 Apr 2025 09:30:50 -0500
Message-ID: <86167ea5-8bc4-4aa6-a980-8d9e37c776ae@kernel.org>
In-Reply-To: <
 <CAHUa44EczHYv0mNrMMbF-Vwc3jbOJqPy5sMsiW=0v2o1UaVfBw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3767922361766534342=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3767922361766534342==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 4/28/2025 9:27 AM, Jens Wiklander wrote:
> Hi,
>=20
> On Mon, Apr 21, 2025 at 5:22=E2=80=AFPM Mario Limonciello <superm1@kernel=
.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> I just noticed a few small things for amdtee where the error messages
>> didn't consistently use the driver name.  While fixing that I noticed
>> the headers weren't sorted.
>>
>> These patches fix both issues.
>>
>> Mario Limonciello (2):
>>    tee: Use pr_fmt for messages
>>    tee: Sort header includes
>>
>>   drivers/tee/amdtee/core.c | 16 +++++++++-------
>>   1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> I'm trying to build this, but I run into some selinux build error. How
> did you build this?

I used kworkflow (kw b).  It was based off linux-next at the time I=20
submitted it.

Can you share your .config?  Is it a defconfig?

Let me pull the tee tree directly and try again with that tree and I'll=20
see if I can reproduce the build error.


--===============3767922361766534342==--

