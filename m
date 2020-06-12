From: Jerome Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [op-tee] [llvm-dev] Issue with __attribute__((constructor)) and
 -Os -fno-common
Date: Fri, 12 Jun 2020 10:05:12 +0200
Message-ID: <726bd030-b37c-157d-a865-6d3962709a83@forissier.org>
In-Reply-To: <
 <CAA2zVHojCzgmj7b5JC8kO9+pmKn0omhw7W3uueZZD=LxRCrq+A@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1948334956606655548=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1948334956606655548==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit



On 6/11/20 11:25 PM, James Y Knight wrote:
> The global constructor was removed by setting the initial value of "val" to
> 1 instead of 0. So, the behavior of this program is preserved. Doesn't look
> like erroneous behavior.

OK, my example is too simplified indeed. Please consider the following
instead:

int val;

static void __attribute__((constructor)) init_fn(void)
{
	val++;
}

int main(int argc, char *argv[])
{
	return val;
}

With this, clang -Os -fno-common generates a global variable initialized
to 1 and discards init_fn().

Now, what happens if the executable is later linked against a shared
library which has its own constructor and sets "val" to some non-zero
value? I mean this for instance:

extern int val;

static void __attribute__((constructor)) so_init_fn(void)
{
	val = 1;
}

I would expect the main program to return 2, not 1.

Last thing, if I define "val" as volatile, the programs behaves as expected.

Are we in "unspecified, just don't do this" territory here?

Thanks,
-- 
Jerome

> 
> On Thu, Jun 11, 2020 at 10:12 AM Jerome Forissier via llvm-dev <
> llvm-dev(a)lists.llvm.org> wrote:
> 
>> Hi,
>>
>> I think that Clang erroneously discards a function annotated with
>> __attribute__((constructor)) when flags -Os -fno-common are given. Test
>> case below.
>>
>> What do you think?
>>
>> Thanks.
>>
>> ----8<--------8<--------8<--------8<--------8<--------8<--------
>> $ cat ctor.c
>> int val;
>>
>> static void __attribute__((constructor)) init_fn(void)
>> {
>>         val = 1;
>> }
>>
>> int main(int argc, char *argv[])
>> {
>>         return val;
>> }
>> ----8<--------8<--------8<--------8<--------8<--------8<--------
>>
>> Here is what I observed:
>>
>> - Clang (10.0.0-4ubuntu1) with -Os -fno-common: function init_fn() is
>> NOT emitted,
>> - Clang (10.0.0-4ubuntu1) with no flag, or only -Os or -fno-common:
>> init_fn() is present as expected,
>> - GCC (Ubuntu 9.3.0-10ubuntu1) with the same flags: init_fn() is present
>> too,
>> - Since https://reviews.llvm.org/D75056, -fno-common is the default and
>> therefore -Os is enough to cause the issue.
>>
>> ----8<--------8<--------8<--------8<--------8<--------8<--------
>> $ clang --target=arm-linux-gnueabihf -Os -fno-common -S ctor.c \
>>   -o /dev/stdout | grep init_fn
>> $ clang --target=arm-linux-gnueabihf -Os -S ctor.c \
>>   -o /dev/stdout | grep init_fn
>>         .p2align        2               @ -- Begin function init_fn
>>         .type   init_fn,%function
>>         .code   32                      @ @init_fn
>> init_fn:
>>         .size   init_fn, .Lfunc_end0-init_fn
>>         .long   init_fn(target1)
>>         .addrsig_sym init_fn
>> $ clang --target=arm-linux-gnueabihf -fno-common -S ctor.c \
>>   -o /dev/stdout | grep init_fn
>>         .p2align        2               @ -- Begin function init_fn
>>         .type   init_fn,%function
>>         .code   32                      @ @init_fn
>> init_fn:
>>         .size   init_fn, .Lfunc_end0-init_fn
>>         .long   init_fn(target1)
>>         .addrsig_sym init_fn
>> $ arm-linux-gnueabihf-gcc -Os -fno-common -S ctor.c \
>>   -o /dev/stdout | grep init_fn
>>         .type   init_fn, %function
>> init_fn:
>>         .size   init_fn, .-init_fn
>>         .word   init_fn(target1)
>> ----8<--------8<--------8<--------8<--------8<--------8<--------
>>
>> --
>> Jerome
>> _______________________________________________
>> LLVM Developers mailing list
>> llvm-dev(a)lists.llvm.org
>> https://lists.llvm.org/cgi-bin/mailman/listinfo/llvm-dev
>>
> 

--===============1948334956606655548==--

