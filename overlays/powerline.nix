self: super:
{
    powerline = super.powerline.override { i3ipc = null; };
}
