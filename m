From: Sean Christopherson <seanjc@google.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 2/9] crypto: ccp: Add a header for multiple drivers to
 use `__psp_pa`
Date: Tue, 07 Mar 2023 15:42:33 -0800
Message-ID: <ZAfL6SK0jMtsAhGv@google.com>
In-Reply-To: <20230303165050.2918-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6183544484447463136=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6183544484447463136==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023, Mario Limonciello wrote:
> The TEE subdriver for CCP, the amdtee driver and the i2c-designware-amdpsp
> drivers all include `psp-sev.h` even though they don't use SEV
> functionality.
>=20
> Move the definition of `__psp_pa` into a common header to be included
> by all of these drivers.
>=20
> Reviewed-by: Jan Dabros <jsd@semihalf.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com> # For the drivers=
/i2c/busses/i2c-designware-amdpsp.c
> Acked-by: Sumit Garg <sumit.garg@linaro.org> # For TEE subsystem bits
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com> # KVM

--===============6183544484447463136==--

