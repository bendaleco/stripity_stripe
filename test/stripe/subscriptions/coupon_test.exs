defmodule Stripe.CouponTest do
  use Stripe.StripeCase, async: true

  test "is listable" do
    assert {:ok, %Stripe.List{data: coupons}} = Stripe.Coupon.list()
    assert_stripe_requested(:get, "/v1/coupons")
    assert is_list(coupons)
    assert %Stripe.Coupon{} = hd(coupons)
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Coupon{}} = Stripe.Coupon.retrieve("25OFF")
    assert_stripe_requested(:get, "/v1/coupons/25OFF")
  end

  test "is creatable" do
    params = %{percent_off: 25, duration: "repeating", duration_in_months: 3, id: "25OFF"}
    assert {:ok, %Stripe.Coupon{}} = Stripe.Coupon.create(params)
    assert_stripe_requested(:post, "/v1/coupons")
  end

  test "is updateable" do
    assert {:ok, %Stripe.Coupon{}} = Stripe.Coupon.update("25OFF", %{metadata: %{key: "value"}})
    assert_stripe_requested(:post, "/v1/coupons/25OFF")
  end

  test "is deleteable" do
    assert {:ok, %{deleted: deleted, id: _id}} = Stripe.Coupon.delete("25OFF")
    assert_stripe_requested(:delete, "/v1/coupons/25OFF")
    assert deleted == true
  end
end
