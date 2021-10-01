From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 0/5] Add FF-A support in OP-TEE driver
Date: Fri, 01 Oct 2021 10:29:39 +0100
Message-ID: <20211001092939.heiskb5gqzx3nd7p@bogus>
In-Reply-To: <20210831072412.887565-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6060495595659804387=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6060495595659804387==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 31, 2021 at 09:24:07AM +0200, Jens Wiklander wrote:
> Hi all,
>=20
> This adds supports for the OP-TEE driver to communicate with secure world
> using FF-A [1] as transport.
>=20
> There is one change to the TEE subsystem with "tee: add sec_world_id to
> struct tee_shm" to add support for holding globally unique handle assigned
> by the FF-A. This is a field that I believe could useful for the AMDTEE
> driver too.
>=20
> For communication the OP-TEE message protocol is still used, but with a new
> type of memory reference, struct optee_msg_param_fmem, to carry the
> information needed by FF-A. The OP-TEE driver is refactored internally with
> to sets of callbacks, one for the old SMC based communication and another
> set with FF-A as transport. The functions relating to the SMC based ABI
> are moved to smc_abi.c while the FF-A based ABI is added in a ffa_abi.c.
>=20
> There is also a difference in how the drivers are instantiated. With the
> SMC based transport we have a platform driver, module_platform_driver(),
> today which we're keeping as is for this configuration. In a FF-A system we
> have a FF-A driver, module_ffa_driver(), instead.
>=20
> The OP-TEE driver can be compiled for both targets at the same time and
> it's up to runtime configuration (device tree or ACPI) to decide how it's
> initialized. Note that it's only the old SMC based driver instance that
> need device tree or ACPI to initialize. The FF-A based driver relies on the
> FF-A bus instead.
>=20
> This can be tested QEMU
> The repo for SPMC at S-EL1 retrieved by
> repo init -u https://github.com/jenswi-linaro/manifest.git -m
> qemu_v8.xml -b ffav4_spmc
> repo sync
> # Then checkout the branch optee_ffa_v5 from
> # git://git.linaro.org/people/jens.wiklander/linux-tee.git
> # in the linux directory
>=20
> To build do:
> cd build
> make toolchains
> make all
>=20
> To boot:
> make run-only
>=20
> Test with xtest, perhaps only with the command "xtest 1004" in case you're
> not interested in too many tests.
>=20

Ran entire xtest test suite with latest TF-A, hafinum and OPTEE.
So for the series,

Tested-by:  Sudeep Holla <sudeep.holla@arm.com>

Minor comments to address OPTEE as module when FFA is also built as module.
FFA as a module couple of bugs(thanks for reporting one of them). I have the
fixes here[1], please test and provide feedback.

--=20
Regards,
Sudeep

[1] https://lore.kernel.org/linux-arm-kernel/20210924092859.3057562-1-sudeep.=
holla(a)arm.com/

--===============6060495595659804387==--

