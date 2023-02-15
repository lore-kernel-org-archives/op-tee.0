From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/6] crypto: ccp: Add a header for multiple drivers to use
 `__psp_pa`
Date: Wed, 15 Feb 2023 13:13:10 +0200
Message-ID: <72567585-0091-7bf4-35b3-ce3f94936bcc@linux.intel.com>
In-Reply-To: <
 <CAOtMz3OfGFsiThY7hQYG2oh1=HKg7N56cuA28e+dhB4EtZsz=Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5886944532861267865=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5886944532861267865==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On 2/14/23 10:40, Jan Dąbroś wrote:
>> The TEE subdriver for CCP, the amdtee driver and the i2c-designware-amdpsp
>> drivers all include `psp-sev.h` even though they don't use SEV
>> functionality.
>>
>> Move the definition of `__psp_pa` into a common header to be included
>> by all of these drivers.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Reviewed-by: Jan Dabros <jsd@semihalf.com>

For the drivers/i2c/busses/i2c-designware-amdpsp.c:

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

--===============5886944532861267865==--

