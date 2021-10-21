From: Arnd Bergmann <arnd@arndb.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] OP-TEE FF-A for V5.16
Date: Thu, 21 Oct 2021 13:30:39 +0200
Message-ID: 
 <CAK8P3a0Z-Hh9xav1peg8LqGoPaHnrt9eo453QmwKrWcWwWAEXw@mail.gmail.com>
In-Reply-To: <20211018121324.GA2943530@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1491816675183506740=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1491816675183506740==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, Oct 18, 2021 at 2:13 PM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>       optee: isolate smc abi

This one caused a randconfig build regression on 32-bit arm:

/git/arm-soc/drivers/tee/optee/smc_abi.c:405:15: error: implicit
declaration of function 'page_to_section'
[-Werror,-Wimplicit-function-declaration]
        optee_page = page_to_phys(*pages) +
                     ^
/git/arm-soc/arch/arm/include/asm/memory.h:148:43: note: expanded from
macro 'page_to_phys'
#define page_to_phys(page)      (__pfn_to_phys(page_to_pfn(page)))
                                               ^
/git/arm-soc/include/asm-generic/memory_model.h:52:21: note: expanded
from macro 'page_to_pfn'
#define page_to_pfn __page_to_pfn
                    ^
/git/arm-soc/include/asm-generic/memory_model.h:35:14: note: expanded
from macro '__page_to_pfn'
        int __sec = page_to_section(__pg);                      \
                    ^
/git/arm-soc/drivers/tee/optee/smc_abi.c:405:15: note: did you mean
'__nr_to_section'?
/git/arm-soc/arch/arm/include/asm/memory.h:148:43: note: expanded from
macro 'page_to_phys'
#define page_to_phys(page)      (__pfn_to_phys(page_to_pfn(page)))
                                               ^
/git/arm-soc/include/asm-generic/memory_model.h:52:21: note: expanded
from macro 'page_to_pfn'
#define page_to_pfn __page_to_pfn
                    ^
/git/arm-soc/include/asm-generic/memory_model.h:35:14: note: expanded
from macro '__page_to_pfn'
        int __sec = page_to_section(__pg);                      \
                    ^
/git/arm-soc/include/linux/mmzone.h:1365:35: note: '__nr_to_section'
declared here
static inline struct mem_section *__nr_to_section(unsigned long nr)

I have not investigated it, but it's probably trivial. Can have a look
and send a fix to
soc(a)kernel.org?

      Arnd

--===============1491816675183506740==--

