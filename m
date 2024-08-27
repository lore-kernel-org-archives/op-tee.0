From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/7] firmware: arm_ffa: FF-A basic v1.2 support
Date: Tue, 27 Aug 2024 15:23:54 +0100
Message-ID: <172476858317.1462451.6804614071493160194.b4-ty@arm.com>
In-Reply-To: <20240820-ffa_v1-2-v2-0-18c0c5f3c65e@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6783247699063218428=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6783247699063218428==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 15:27:53 +0100, Sudeep Holla wrote:
> This series add basic support for FF-A v1.2.
> It mainly includes support for newly added:
> 1. FFA_MSG_SEND_DIRECT_{REQ,RESP}2
> 2. FFA_PARTITION_INFO_GET_REGS
> 3. FFA_YIELD support in direct messaging
> 
> Apart from these, the changes include support to fetch the Rx/Tx buffer
> size using FFA_FEATURES, addition of the FF-A FIDs for v1.2 and some
> coding style cleanups.
> 
> [...]

Applied to sudeep.holla/linux (for-next/ffa/updates), thanks!

[1/7] firmware: arm_ffa: Some coding style fixes
      https://git.kernel.org/sudeep.holla/c/fbbb0e5fd260
[2/7] firmware: arm_ffa: Update the FF-A command list with v1.2 additions
      https://git.kernel.org/sudeep.holla/c/7c432a18ad21
[3/7] firmware: arm_ffa: Move the function ffa_features() earlier
      https://git.kernel.org/sudeep.holla/c/d37fff98262d
[4/7] firmware: arm_ffa: Add support for FFA_PARTITION_INFO_GET_REGS
      https://git.kernel.org/sudeep.holla/c/ba85c644ac8d
[5/7] firmware: arm_ffa: Add support for FFA_MSG_SEND_DIRECT_{REQ,RESP}2
      https://git.kernel.org/sudeep.holla/c/aaef3bc98129
[6/7] firmware: arm_ffa: Add support for FFA_YIELD in direct messaging
      https://git.kernel.org/sudeep.holla/c/eaca7ef8f31a
[7/7] firmware: arm_ffa: Fetch the Rx/Tx buffer size using ffa_features()
      https://git.kernel.org/sudeep.holla/c/61824feae5c0
--
Regards,
Sudeep


--===============6783247699063218428==--

