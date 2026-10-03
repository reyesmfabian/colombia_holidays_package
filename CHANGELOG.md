#### [2.2.0] - Fix holidays and isHoliday

- Fix `isHoliday` returning `false` for days 1-9 (e.g. January 1st).
- Fix Holy Week, Ascension, Corpus Christi and Sacred Heart dates in years with wrong Easter calculation (1954, 1981, 2049, 2076 and every year from 2100).
- Fix typo in holiday name: `Corphus Christi` -> `Corpus Christi`.
- Reject day 0 and month 0 in `isHoliday`.
- Load and parse holidays only once.
- Require Dart 3 and update `flutter_lints` to 6.0.0.

#### [2.1.5] - Update dependencies

#### [2.0.2] - Add Documentation

#### [2.0.1] - Add Documentation

#### [2.0.0] - Production Release

#### [1.0.4] - Fix Holidays

#### [1.0.3] - Add Tests

#### [1.0.2] - Minor Fix

#### [1.0.1] - Add Documentation

#### [1.0.0] - Initial releas
