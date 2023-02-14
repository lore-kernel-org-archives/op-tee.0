From: Jan Dąbroś <jsd@semihalf.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/6] crypto: ccp: Add a header for multiple drivers to use
 `__psp_pa`
Date: Tue, 14 Feb 2023 08:40:47 +0000
Message-ID: 
 <CAOtMz3OfGFsiThY7hQYG2oh1=HKg7N56cuA28e+dhB4EtZsz=Q@mail.gmail.com>
In-Reply-To: <20230209223811.4993-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5181082556409631466=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5181082556409631466==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

> The TEE subdriver for CCP, the amdtee driver and the i2c-designware-amdpsp
> drivers all include `psp-sev.h` even though they don't use SEV
> functionality.
>
> Move the definition of `__psp_pa` into a common header to be included
> by all of these drivers.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Jan Dabros <jsd@semihalf.com>

--===============5181082556409631466==--

