From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 00/10] firmware: arm_ffa: Refactoring and initial/minor
 v1.1 update
Date: Thu, 08 Sep 2022 12:24:16 +0100
Message-ID: <166263613429.1889754.11330926190281757716.b4-ty@arm.com>
In-Reply-To: <20220907145240.1683088-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2050772089373557302=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2050772089373557302==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Sep 2022 15:52:30 +0100, Sudeep Holla wrote:
> This series is just some refactoring in preparation to add FF-A v1.1
> support. It doesn't have any memory layout or notification changes
> supported in v1.1 yet.
>=20
> Regards,
> Sudeep
>=20
> [...]

Applied to sudeep.holla/linux (for-next/ffa), thanks!

[01/10] firmware: arm_ffa: Add pointer to the ffa_dev_ops in struct ffa_dev
        https://git.kernel.org/sudeep.holla/c/d01387fc1642
[02/10] tee: optee: Drop ffa_ops in optee_ffa structure using ffa_dev->ops di=
rectly
        https://git.kernel.org/sudeep.holla/c/320c3fa38c51
[03/10] firmware: arm_ffa: Remove ffa_dev_ops_get()
        https://git.kernel.org/sudeep.holla/c/55bf84fd0a76
[04/10] firmware: arm_ffa: Add support for querying FF-A features
        https://git.kernel.org/sudeep.holla/c/cb1f4c2c15bb
[05/10] firmware: arm_ffa: Use FFA_FEATURES to detect if native versions are =
supported
        https://git.kernel.org/sudeep.holla/c/e57fba9105fa
[06/10] firmware: arm_ffa: Make memory apis ffa_device independent
        https://git.kernel.org/sudeep.holla/c/8c3812c8f74f
[07/10] firmware: arm_ffa: Rename ffa_dev_ops as ffa_ops
        https://git.kernel.org/sudeep.holla/c/7aa7a9798955
[08/10] firmware: arm_ffa: Add v1.1 get_partition_info support
        https://git.kernel.org/sudeep.holla/c/bb1be7498500
[09/10] firmware: arm_ffa: Set up 32bit execution mode flag using partiion pr=
operty
	(with the additional version check as discussed on the list)
        https://git.kernel.org/sudeep.holla/c/106b11b1ccd5
[10/10] firmware: arm_ffa: Split up ffa_ops into info, message and memory ope=
rations
        https://git.kernel.org/sudeep.holla/c/5b0c6328e47d

--
Regards,
Sudeep


--===============2050772089373557302==--

