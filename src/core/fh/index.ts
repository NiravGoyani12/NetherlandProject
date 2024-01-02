import { fhQuery, fhQueryOnSale } from './query';
import { getProductStyleColoursWithStoreAvailaibility } from './products';

const fh = {
  query: fhQuery,
  queryOnSale: fhQueryOnSale,
  getStyleColourOfStoreAvailibility: getProductStyleColoursWithStoreAvailaibility,
};
export default fh;
