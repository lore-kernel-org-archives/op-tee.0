From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4] rtc: optee: add RTC driver for OP-TEE RTC PTA
Date: Fri, 25 Mar 2022 11:43:27 +0100
Message-ID: <164820498345.150187.420135785211936016.b4-ty@bootlin.com>
In-Reply-To: <20220308133505.471601-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3733672196010755012=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3733672196010755012==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 8 Mar 2022 14:35:05 +0100, Clément Léger wrote:
> This drivers allows to communicate with a RTC PTA handled by OP-TEE [1].
> This PTA allows to query RTC information, set/get time and set/get
> offset depending on the supported features.
> 
> [1] https://github.com/OP-TEE/optee_os/pull/5179
> 
> 
> [...]

Applied, thanks!

[1/1] rtc: optee: add RTC driver for OP-TEE RTC PTA
      commit: 81c2f059ab90b221931e78503c80dcd8fbadac53

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--===============3733672196010755012==--

