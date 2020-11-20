From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Fri, 20 Nov 2020 13:02:34 -0600
Message-ID: <9f986394-125a-81f7-7696-fe1a9f4eb4f5@embeddedor.com>
In-Reply-To: <3e0bbb1644fe53d79322c2feb28ccaf3e20c0e94.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6857799750890961717=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6857799750890961717==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit



On 11/20/20 12:28, Joe Perches wrote:
> On Fri, 2020-11-20 at 12:21 -0600, Gustavo A. R. Silva wrote:
>> Hi all,
>>
>> This series aims to fix almost all remaining fall-through warnings in
>> order to enable -Wimplicit-fallthrough for Clang.
>>
>> In preparation to enable -Wimplicit-fallthrough for Clang, explicitly
>> add multiple break/goto/return/fallthrough statements instead of just
>> letting the code fall through to the next case.
>>
>> Notice that in order to enable -Wimplicit-fallthrough for Clang, this
>> change[1] is meant to be reverted at some point. So, this patch helps
>> to move in that direction.
> 
> This was a bit hard to parse for a second or three.
> 
> Thanks Gustavo.
> 
> How was this change done?

I audited case by case in order to determine the best fit for each
situation. Depending on the surrounding logic, sometimes it makes
more sense a goto or a fallthrough rather than merely a break.

Thanks
--
Gustavo

--===============6857799750890961717==--

