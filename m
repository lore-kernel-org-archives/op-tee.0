From: Jerome Forissier <jerome.forissier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: optee: os: toolchains would include linux target macros likes __linux__
Date: Mon, 04 Dec 2023 18:08:59 +0100
Message-ID: <b66dc60e-78ad-46f6-9ad6-430f288af018@linaro.org>
In-Reply-To: <
 <CAHUa44FEkdtA+4AuoQnNEnObKzcUX3qkFD8iV8Z_pGJ7ZPWw2A@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3599784587892621199=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3599784587892621199==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit



On 12/4/23 17:34, Jens Wiklander wrote:
> Hi Randy,
> 
> On Mon, Dec 4, 2023 at 2:39 PM Randy Li <ayaka@soulik.info> wrote:
>>
>> Hello
>>
>> I wonder why Optee OS would use a linux target toolchains but not a bare
>> metal target(none os)?
> 
> I guess it started with that we didn't want to download both one Linux
> and one bare metal toolchain. We need both AArch32 and AArch64
> versions so it doubles up.

To expand on this: when building a complete OP-TEE setup like we do with
https://github.com/OP-TEE/manifest, there are many different runtime
environments: the Linux kernel, client applications, OP-TEE OS, Trusted
Applications, EL3 firmware... Some of them require a Linux toolchain
(the OP-TEE client library, tee-supplicant as well as the client
applications). So the idea was, if we could build all the software with a
Linux toolchain, it would simplify things. Since then we found out there
are caveats but it mostly works.

-- 
Jerome

--===============3599784587892621199==--

