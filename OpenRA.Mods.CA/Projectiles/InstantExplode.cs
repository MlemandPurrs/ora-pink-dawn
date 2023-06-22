﻿#region Copyright & License Information
/**
 * Copyright (c) The OpenRA Combined Arms Developers (see CREDITS).
 * This file is part of OpenRA Combined Arms, which is free software.
 * It is made available to you under the terms of the GNU General Public License
 * as published by the Free Software Foundation, either version 3 of the License,
 * or (at your option) any later version. For more information, see COPYING.
 */
#endregion

using System.Collections.Generic;
using OpenRA.GameRules;
using OpenRA.Graphics;
using OpenRA.Traits;

namespace OpenRA.Mods.CA.Projectiles
{
	public class InstantExplodeInfo : IProjectileInfo
	{
		public IProjectile Create(ProjectileArgs args) { return new InstantExplode(this, args); }
	}

	class InstantExplode : IProjectile
	{
		readonly ProjectileArgs args;

		public InstantExplode(InstantExplodeInfo info, ProjectileArgs args)
		{
			this.args = args;
		}

		public void Tick(World world)
		{
			world.AddFrameEndTask(w => w.Remove(this));

			args.Weapon.Impact(Target.FromPos(args.Source), new WarheadArgs(args));
		}

		public IEnumerable<IRenderable> Render(WorldRenderer wr)
		{
			yield break;
		}
	}
}
