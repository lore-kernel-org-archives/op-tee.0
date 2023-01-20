From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Linaro OP-TEE Contribution (LOC) monthly meeting January 24
Date: Fri, 20 Jan 2023 17:59:20 +0100
Message-ID: <Y8rIaFxLgygd9LlK@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4834049316270953718=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4834049316270953718==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

It's soon time for another LOC monthly meeting. For time and connection
details see the calendar at https://www.trustedfirmware.org/meetings/

I have one topic to discuss:

OP-TEE 3.20.0 is just released and a PR [1] to upgrade from TEE Internal
Core API version 1.1 to 1.3.1 is soon to be merged. This may bump the
major OP-TEE version in the next release. There's in particular the
define TEE_ALG_SM2_PKE which is tricky to keep compatible when
upgrading. We have some time until the next release to determine if this
is reason enough to bump the major version.

Any other topics?

[1] https://github.com/OP-TEE/optee_os/pull/5688

Thanks,
Jens

--===============4834049316270953718==--

