import qualified Data.Map as M
import           XMonad
import qualified XMonad.StackSet as W
import XMonad.Layout.BoringWindows
import XMonad.Layout.ResizableTile
import XMonad.Wallpaper

main = do
  setRandomWallpaper ["$HOME/.config/wallpapers"]
  xmonad $ def {
    layoutHook =  boringWindows $ tall ||| Full,
    modMask = altMask .|. windowsMask,
    keys = \conf -> myKeys conf `M.union` keys def conf
    }
    where
      altMask = mod1Mask
      windowsMask = mod4Mask
      noMask = 0
      tall = ResizableTall {
        _nmaster = 1,     -- number of master windows
        _delta = (3/100), -- change when resizing
        _frac = (1/2),    -- width of master
        _slaves = [ 2 ] } -- fraction to multiply to slave window heights
      myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
        [ ((modm, xK_r), refresh)
         ,((modm, xK_d), sendMessage Shrink)
         ,((modm, xK_minus), sendMessage Expand)
         ,((modm, xK_s), sendMessage MirrorShrink)
         ,((modm, xK_h), sendMessage MirrorExpand)
         ,((modm, xK_n), focusDown)
         ,((modm .|. shiftMask, xK_n), windows W.swapDown)
         ,((modm, xK_t), focusUp)
         ,((modm .|. shiftMask, xK_t), windows W.swapUp)
          
        ] ++ [
          ((modm .|. mask, key), screenWorkspace scrId >>= flip whenJust (windows . f))
            | (key, scrId) <- zip [xK_a, xK_o, xK_e, xK_u] [0..]
             ,(mask,f)    <- [(noMask, W.view), (shiftMask, W.shift)]
        ]
  
