import { BitcoinBarometerEntityBase } from '../BitcoinBarometerEntityBase';
import type { BitcoinBarometerSDK } from '../BitcoinBarometerSDK';
import type { Control } from '../types';
import type { Badge, BadgeLoadMatch } from '../BitcoinBarometerTypes';
declare class BadgeEntity extends BitcoinBarometerEntityBase<Badge> {
    constructor(client: BitcoinBarometerSDK, entopts: any);
    make(this: BadgeEntity): BadgeEntity;
    load(this: any, reqmatch?: BadgeLoadMatch, ctrl?: Control): Promise<BadgeEntity>;
}
export { BadgeEntity };
