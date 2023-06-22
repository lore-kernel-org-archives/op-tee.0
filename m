From: Jan Kiszka <jan.kiszka@siemens.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 4/4] efivarfs: automatically update super block flag
Date: Thu, 22 Jun 2023 14:58:56 +0000
Message-ID: <5fe03be6-8c95-0bfa-687d-68e7ddffd97c@siemens.com>
In-Reply-To: <20230622085112.1521-5-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0292094797453484547=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0292094797453484547==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On 22.06.23 10:51, Masahisa Kojima wrote:
> efivar operation is updated when the tee_stmm_efi module is probed.
> tee_stmm_efi module supports SetVariable runtime service,
> but user needs to manually remount the efivarfs as RW to enable
> the write access if the previous efivar operation does not support
> SerVariable and efivarfs is mounted as read-only.
> 
> This commit notifies the update of efivar operation to
> efivarfs subsystem, then drops SB_RDONLY flag if the efivar
> operation supports SetVariable.

But it does not re-add it and prevents further requests to the TA (that
will only cause panics there) when the daemon terminates, does it?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


--===============0292094797453484547==--

