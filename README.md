# Cress

The first development stage of Aevom, built upon the code adopted from the
historical [Unix v0](https://github.com/DoctorWkt/pdp7-unix) implementation.

## Supported Architecture

- PDP-7, an 18-bit minicomputer produced by Digital Equipment Corporation in 1965.

## Build and Run

Cress requires [Perl](https://www.perl.org) to build and SIMH 4.0 for emulation.

[Aevom's fork of SIMH](https://github.com/aevom-labs/simh) is recommended.

To compile:
```
make
```

To compile and run:
```
make run
```
Ensure that the `pdp7` SIMH emulator target is compiled and available in your `PATH`.

## License

This project is licensed under the [GNU General Public License, Version 3.0](LICENSE).