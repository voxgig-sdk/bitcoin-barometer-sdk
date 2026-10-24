import { BitcoinBarometerEntityBase } from '../BitcoinBarometerEntityBase';
import type { BitcoinBarometerSDK } from '../BitcoinBarometerSDK';
import type { Control } from '../types';
import type { Barometer, BarometerListMatch } from '../BitcoinBarometerTypes';
declare class BarometerEntity extends BitcoinBarometerEntityBase<Barometer> {
    constructor(client: BitcoinBarometerSDK, entopts: any);
    make(this: BarometerEntity): BarometerEntity;
    list(this: any, reqmatch?: BarometerListMatch, ctrl?: Control): Promise<BarometerEntity[]>;
}
export { BarometerEntity };
