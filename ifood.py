import json
import logging

import requests

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def fetch_orders(page=0, size=25):
    token = ""
    headers = {"Authorization": token}
    url = "https://marketplace.ifood.com.br/v4/customers/me/orders"
    params = {"page": page, "size": size}
    logger.info(f"Fetching orders from page {page}")
    response = requests.get(url, headers=headers, params=params)
    return response.json()


def depaginate_orders():
    orders = []
    page = 0
    while True:
        response = fetch_orders(page=page)
        if not response:
            break
        orders.extend(response)
        page += 1
    with open("all_orders_2.json", "w") as f:
        json.dump(orders, f, indent=2)


def get_all_merchants(orders):
    merchants = set()
    for order in orders:
        merchants.add(order["merchant"]["name"])
    return merchants


def get_all_items(orders):
    items = {}
    for order in orders:
        for item in order["bag"]["items"]:
            name = item["name"]
            price = item["unitPrice"]
            quantity = item["quantity"]
            import pdb; pdb.set_trace()
            if price > 0:
                if name not in items:
                    items[name] = {"price": price, "quantity": quantity}
                else:
                    items[name]["quantity"] += quantity

    for item, info in items.items():
        info["total"] = info["price"] * info["quantity"] / 100
    items = list(items.items())
    items.sort(key=lambda x: x[1]["total"], reverse=True)
    return items


def get_total_per_merchant(orders, date=None):
    merchants = get_all_merchants(orders)
    orders_per_merchant = []
    for merchant in merchants:
        total = calculate_total(orders, date=date, merchant=merchant)
        if total["total"] == 0:
            continue
        orders_per_merchant.append((merchant, total))

    orders_per_merchant.sort(key=lambda x: x[1]["total"], reverse=True)
    return orders_per_merchant


def calculate_total(orders, date=None, merchant=None):
    total = 0
    num_orders = 0
    for order in orders:
        if order["lastStatus"] != "CONCLUDED":
            continue
        if date and date not in order["createdAt"]:
            continue
        if merchant and merchant != order["merchant"]["name"]:
            continue
        payment = order["payments"]["total"]["value"]
        total += payment / 100
        num_orders += 1
    return {"total": total, "num_orders": num_orders}


def main():
    # depaginate_orders()
    orders = json.load(open("all_orders.json"))
    orders_2 = json.load(open("all_orders_2.json"))
    orders.extend(orders_2)

    # merchants = get_all_merchants(orders)
    date = "2024"
    total = calculate_total(orders, date=date)
    print(total)

    print("MERCHANTS")
    orders_per_merchant = get_total_per_merchant(orders, date=date)
    count = 1
    for merchant, total in orders_per_merchant:
        print(f"{count} {merchant}: {total}")
        count += 1

    # print("\n\n\nITEMS")
    all_items = get_all_items(orders)
    for item, info in all_items:
       print(f"{item}: {info}")

    # randomly select an item
    # import random
    # index = random.randint(0, len(all_items))
    # print(all_items[index])


if __name__ == "__main__":
    main()
