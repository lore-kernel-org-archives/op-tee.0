From: Avri Altman <Avri.Altman@wdc.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: [PATCH v5 0/3] Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 23 Apr 2024 06:42:05 +0000
Message-ID: <DM6PR04MB6575CE5A70F2C733DF40E54CFC112@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <20240422091936.3714381-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6133480206897277133=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6133480206897277133==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

> The OP-TEE driver finds the correct RPMB device to interact with by
> iterating over available devices until one is found with a programmed
> authentication matching the one OP-TEE is using. This enables coexisting
> users of other RPMBs since the owner can be determined by who knows the
> authentication key.
Devices in plural?
I am unaware of any board with multi eMMC devices soldered.
Can you refer me to such a platform?

Thanks,
Avri

--===============6133480206897277133==--

