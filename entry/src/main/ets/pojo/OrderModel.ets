// Define an interface for the props
export interface OrderModelProps {
  currentType: number;
}

// Use the interface in the constructor
export class OrderModel {
  currentType: number;

  constructor(props: OrderModelProps) {
    this.currentType = props.currentType;
  }

  // Add methods or other properties for OrderModel if needed
}
