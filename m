From: Arnd Bergmann <arnd@arndb.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] TEE updates for 6.16
Date: Sat, 10 May 2025 11:10:10 +0200
Message-ID: <a877f411-f6df-45dd-9cf2-351d785db4c2@app.fastmail.com>
In-Reply-To: <
 <CAG48ez3JEg11GZTzmSHeXEDVz9vN68vWjTH+2sq_6+8eK0zkig@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6368230659989107256=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6368230659989107256==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, May 9, 2025, at 23:22, Jann Horn wrote:
> On Fri, May 9, 2025 at 11:14 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> The second patch looks like it should be a bugfix for 6.15 instead,
>> any reason to have it only in 6.16?
>
> FWIW, it's more of a cleanup than a real bugfix; there is an unsigned
> integer wraparound, but if that occurs, we're guaranteed to hit a
> memory allocation bailout pretty much immediately afterwards. So I
> think putting it in 6.16 is reasonable.

Ok, I see. Merged now.

     Arnd

--===============6368230659989107256==--

