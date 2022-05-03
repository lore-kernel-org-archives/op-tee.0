From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 1/4] firmware: arm_ffa: Fix uuid parameter to ffa_partition_probe
Date: Tue, 03 May 2022 09:04:36 +0100
Message-ID: <165156463955.2920142.3802443759732063834.b4-ty@arm.com>
In-Reply-To: <20220429113946.2087145-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2579983937916490412=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2579983937916490412==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 29 Apr 2022 12:39:43 +0100, Sudeep Holla wrote:
> While we pass uuid_null intentionally to ffa_partition_probe in
> ffa_setup_partitions to get the count of the partitions, it must not be
> uuid_null in ffa_partition_info_get which is used by the ffa_drivers
> to fetch the specific partition info passing the UUID of the partition.
> 
> Fix ffa_partition_info_get by passing the received uuid down to
> ffa_partition_probe so that the correct partition information is fetched.
> 
> [...]

Applied to sudeep.holla/linux (for-next/ffa), thanks!

[1/4] firmware: arm_ffa: Fix uuid parameter to ffa_partition_probe
      https://git.kernel.org/sudeep.holla/c/f3c45c045e
[2/4] firmware: arm_ffa: Remove incorrect assignment of driver_data
      https://git.kernel.org/sudeep.holla/c/00512d2930
[3/4] firmware: arm_ffa: Add ffa_dev_get_drvdata helper function
      https://git.kernel.org/sudeep.holla/c/498af8d167
[4/4] tee: optee: Use ffa_dev_get_drvdata to fetch driver_data
      https://git.kernel.org/sudeep.holla/c/f3f3bdbd58

--
Regards,
Sudeep


--===============2579983937916490412==--

