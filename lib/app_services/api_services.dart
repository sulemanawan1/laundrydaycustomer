import 'package:flutter/material.dart';
import 'package:laundryday/models/item_model.dart';
import 'package:laundryday/models/service_types_model.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/models/service_images.dart';
import 'package:laundryday/models/services_model.dart';

class ApiServices {
  Future<List<LaundryModel>> getAllLaundries({required serviceId}) async {
    await Future.delayed(const Duration(seconds: 0));
    List<LaundryModel> items = [
      LaundryModel(
          service: ServicesModel(
              vat: 15.0,
              id: 1,
              name: 'Clothes',
              deliveryFee: 14.0,
              operationFee: 2.0,
              image: 'assets/services_clothing.jpg',
              images: [
                ServiceImage(image: 'assets/clothes_1.jpg'),
                ServiceImage(image: 'assets/clothes_2.jpg'),
                ServiceImage(image: 'assets/clothes_3.jpg'),
                ServiceImage(image: 'assets/clothes_4.jpg'),
                ServiceImage(image: 'assets/clothes_5.jpg'),
              ]),
          lat: 24.2,
          lng: 44.5,
          rating: 3.0,
          address: "MPR5+M2J, Abu Bakr Alrazi St, As Sulimaniyah, Riyadh 12232",
          userRatingTotal: 25,
          id: 1,
          name: 'Al Nayab',
          placeId: "#place1",
          logo: 'assets/clothing_services_icons.png',
          distance: 2.7,
          type: 'register',
          banner: 'assets/category_banner/clothes_banner.jpg',
          seviceTypes: [
            ServiceTypesModel(
                id: 1,
                serviceId: 1,
                type: 'laundry',
                startingTime: 1,
                endingTime: 2,
                unit: 'Hr'),
            ServiceTypesModel(
                id: 2,
                serviceId: 1,
                type: 'drycleaning',
                startingTime: 30,
                endingTime: 50,
                unit: 'Min'),
            ServiceTypesModel(
                id: 3,
                serviceId: 1,
                type: 'pressing',
                startingTime: 1,
                endingTime: 2,
                unit: 'Hr'),
          ],
          timeslot: [
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 12, minute: 0),
                weekNumber: 1),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 00, minute: 00),
                weekNumber: 2),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 3),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 4),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 5),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 6),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 7),
          ],
          status: 'opened'),

      LaundryModel(
          service: ServicesModel(
            vat: 15.0,
            id: 1,
            name: 'Clothes',
            deliveryFee: 14.0,
            operationFee: 2.0,
            image: 'assets/services_clothing.jpg',
            images: [
              ServiceImage(image: 'assets/clothes_1.jpg'),
              ServiceImage(image: 'assets/clothes_2.jpg'),
              ServiceImage(image: 'assets/clothes_3.jpg'),
              ServiceImage(image: 'assets/clothes_4.jpg'),
              ServiceImage(image: 'assets/clothes_5.jpg'),
            ],
          ),
          lat: 24.2,
          lng: 44.5,
          rating: 5.0,
          address: "Riyadh, 12232",
          userRatingTotal: 25,
          id: 2,
          name: 'Abdullah Haleem Laundrys',
          placeId: "#place1",
          logo: 'assets/clothing_services_icons.png',
          distance: 2.1,
          type: 'register',
          banner: 'assets/category_banner/clothes_banner.jpg',
          seviceTypes: [
            ServiceTypesModel(id: 2, serviceId: 1, type: 'drycleaning'),
            ServiceTypesModel(id: 3, serviceId: 1, type: 'pressing'),
          ],
          timeslot: [
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 1),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 2),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 3),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 4),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 5),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 6),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 7),
          ],
          status: 'closed'),
      LaundryModel(
          service: ServicesModel(
              vat: 15.0,
              id: 1,
              name: 'Clothes',
              deliveryFee: 14.0,
              operationFee: 2.0,
              image: 'assets/services_clothing.jpg',
              images: [
                // ServiceCarouselImage(image: 'assets/clothes_1.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_2.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_3.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_4.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_5.jpg'),
              ]),
          lat: 24.2,
          lng: 44.5,
          rating: 5.0,
          address: "Riyadh, 12232",
          userRatingTotal: 25,
          id: 2,
          name: 'Haadi  Laundrys',
          placeId: "#place1",
          logo: 'assets/clothing_services_icons.png',
          banner: 'assets/category_banner/clothes_banner.jpg',
          distance: 2.1,
          type: 'deliverypickup',
          seviceTypes: [],
          timeslot: [
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 1),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 2),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 3),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 4),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 5),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 6),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 7),
          ],
          status: 'opened'),
      LaundryModel(
          service: ServicesModel(
              vat: 15.0,
              id: 1,
              name: 'Clothes',
              deliveryFee: 14.0,
              operationFee: 2.0,
              image: 'assets/services_clothing.jpg',
              images: [
                // ServiceCarouselImage(image: 'assets/clothes_1.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_2.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_3.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_4.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_5.jpg'),
              ]),
          lat: 24.2,
          lng: 44.5,
          rating: 5.0,
          address: "Riyadh, 12232",
          userRatingTotal: 25,
          id: 2,
          name: 'Haadi  Laundrys',
          placeId: "#place1",
          logo: 'assets/clothing_services_icons.png',
          banner: 'assets/category_banner/clothes_banner.jpg',
          distance: 2.1,
          type: 'deliverypickup',
          seviceTypes: [],
          timeslot: [
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 1),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 2),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 3),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 4),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 5),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 6),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 7),
          ],
          status: 'opened'),
      LaundryModel(
          service: ServicesModel(
              vat: 15.0,
              id: 1,
              name: 'Clothes',
              deliveryFee: 14.0,
              operationFee: 2.0,
              image: 'assets/services_clothing.jpg',
              images: [
                // ServiceCarouselImage(image: 'assets/clothes_1.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_2.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_3.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_4.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_5.jpg'),
              ]),
          lat: 24.2,
          lng: 44.5,
          rating: 5.0,
          address: "Riyadh, 12232",
          userRatingTotal: 25,
          id: 2,
          name: 'Haadi  Laundrys',
          placeId: "#place1",
          logo: 'assets/clothing_services_icons.png',
          banner: 'assets/category_banner/clothes_banner.jpg',
          distance: 2.1,
          type: 'deliverypickup',
          seviceTypes: [],
          timeslot: [
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 1),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 2),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 3),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 4),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 5),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 6),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 7),
          ],
          status: 'opened'),
      LaundryModel(
          service: ServicesModel(
              vat: 15.0,
              id: 1,
              name: 'Clothes',
              deliveryFee: 14.0,
              operationFee: 2.0,
              image: 'assets/services_clothing.jpg',
              images: [
                // ServiceCarouselImage(image: 'assets/clothes_1.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_2.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_3.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_4.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_5.jpg'),
              ]),
          lat: 24.2,
          lng: 44.5,
          rating: 5.0,
          address: "Riyadh, 12232",
          userRatingTotal: 25,
          id: 2,
          name: 'Haadi  Laundrys',
          placeId: "#place1",
          logo: 'assets/clothing_services_icons.png',
          banner: 'assets/category_banner/clothes_banner.jpg',
          distance: 2.1,
          type: 'deliverypickup',
          seviceTypes: [],
          timeslot: [
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 1),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 2),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 3),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 4),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 5),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 6),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 7),
          ],
          status: 'opened'),
      LaundryModel(
          service: ServicesModel(
              vat: 15.0,
              id: 1,
              name: 'Clothes',
              deliveryFee: 14.0,
              operationFee: 2.0,
              image: 'assets/services_clothing.jpg',
              images: [
                // ServiceCarouselImage(image: 'assets/clothes_1.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_2.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_3.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_4.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_5.jpg'),
              ]),
          lat: 24.2,
          lng: 44.5,
          rating: 5.0,
          address: "Riyadh, 12232",
          userRatingTotal: 25,
          id: 2,
          name: 'Haadi  Laundrys',
          placeId: "#place1",
          logo: 'assets/clothing_services_icons.png',
          banner: 'assets/category_banner/clothes_banner.jpg',
          distance: 2.1,
          type: 'deliverypickup',
          seviceTypes: [],
          timeslot: [
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 1),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 2),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 3),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 4),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 5),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 6),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 7),
          ],
          status: 'opened'),
      LaundryModel(
          service: ServicesModel(
              vat: 15.0,
              id: 1,
              name: 'Clothes',
              deliveryFee: 14.0,
              operationFee: 2.0,
              image: 'assets/services_clothing.jpg',
              images: [
                // ServiceCarouselImage(image: 'assets/clothes_1.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_2.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_3.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_4.jpg'),
                // ServiceCarouselImage(image: 'assets/clothes_5.jpg'),
              ]),
          lat: 24.2,
          lng: 44.5,
          rating: 5.0,
          address: "Riyadh, 12232",
          userRatingTotal: 25,
          id: 2,
          name: 'Haadi  Laundrys',
          placeId: "#place1",
          logo: 'assets/clothing_services_icons.png',
          banner: 'assets/category_banner/clothes_banner.jpg',
          distance: 2.1,
          type: 'deliverypickup',
          seviceTypes: [],
          timeslot: [
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 1),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 2),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 3),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 4),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 5),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 6),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 7),
          ],
          status: 'opened'),

      // Blankets

      LaundryModel(
          service: ServicesModel(
              operationFee: 2.0,
              vat: 15.0,
              id: 2,
              deliveryFee: 18.0,
              name: 'Blankets',
              image: 'assets/services_blankets.jpg',
              images: [
                ServiceImage(image: 'assets/blankets_1.jpg'),
                ServiceImage(image: 'assets/blankets_2.jpg'),
              ]),
          lat: 24.2,
          lng: 44.5,
          rating: 3.0,
          address: "Alhazm, Riyadh 14964",
          userRatingTotal: 25,
          id: 1,
          name: 'Fakhir Laundry',
          placeId: "#place1",
          logo: 'assets/clothing_services_icons.png',
          banner: 'assets/blanket_and_linen_banner.jpg',
          distance: 1.6,
          type: 'register',
          seviceTypes: [
            ServiceTypesModel(id: 1, serviceId: 1, type: 'laundry'),
          ],
          timeslot: [
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 1),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 2),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 3),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 4),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 5),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 6),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 7),
          ],
          status: 'opened'),
      LaundryModel(
          service: ServicesModel(
              operationFee: 2.0,
              vat: 15.0,
              id: 2,
              deliveryFee: 18.0,
              name: 'Blankets',
              image: 'assets/services_blankets.jpg',
              images: [
                ServiceImage(image: 'assets/blankets_1.jpg'),
                ServiceImage(image: 'assets/blankets_2.jpg'),
              ]),
          lat: 24.2,
          lng: 44.5,
          rating: 5.0,
          address: " Az Zahrah, Riyadh 12986",
          userRatingTotal: 25,
          id: 2,
          name: 'مغاسل Laundry',
          placeId: "#place1",
          logo: 'assets/clothing_services_icons.png',
          banner: 'assets/blanket_and_linen_banner.jpg',
          distance: 2.8,
          type: 'register',
          seviceTypes: [
            ServiceTypesModel(id: 1, serviceId: 1, type: 'laundry'),
          ],
          timeslot: [
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 1),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 2),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 3),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 4),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 5),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 6),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 7),
          ],
          status: 'opened'),
      LaundryModel(
          service: ServicesModel(
              operationFee: 2.0,
              vat: 15.0,
              id: 2,
              deliveryFee: 18.0,
              name: 'Blankets',
              image: 'assets/services_blankets.jpg',
              images: [
                ServiceImage(image: 'assets/blankets_1.jpg'),
                ServiceImage(image: 'assets/blankets_2.jpg'),
              ]),
          lat: 24.2,
          lng: 44.5,
          rating: 5.0,
          address:
              "4135 Ibn Taymeeyah Rd, حي المروة, RLMA6432, 6432, Riyadh 14721",
          userRatingTotal: 25,
          id: 2,
          name: 'Mahazed Laundry',
          placeId: "#place1",
          logo: 'assets/clothing_services_icons.png',
          banner: 'assets/blanket_and_linen_banner.jpg',
          distance: 3.0,
          type: 'deliverypickup',
          seviceTypes: [],
          timeslot: [
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 1),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 2),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 3),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 4),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 5),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 6),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 7),
          ],
          status: 'opened'),
      LaundryModel(
          service: ServicesModel(
              operationFee: 2.0,
              vat: 15.0,
              id: 2,
              deliveryFee: 18.0,
              name: 'Blankets',
              image: 'assets/services_blankets.jpg',
              images: [
                ServiceImage(image: 'assets/blankets_1.jpg'),
                ServiceImage(image: 'assets/blankets_2.jpg'),
              ]),
          lat: 24.2,
          lng: 44.5,
          rating: 5.0,
          address:
              "4135 Ibn Taymeeyah Rd, حي المروة, RLMA6432, 6432, Riyadh 14721",
          userRatingTotal: 25,
          id: 2,
          name: 'Mahazed Laundry',
          placeId: "#place1",
          logo: 'assets/clothing_services_icons.png',
          banner: 'assets/blanket_and_linen_banner.jpg',
          distance: 3.0,
          type: 'deliverypickup',
          seviceTypes: [],
          timeslot: [
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 1),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 2),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 3),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 4),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 5),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 6),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 7),
          ],
          status: 'opened'),

      // Carpets

      LaundryModel(
          service: ServicesModel(
              vat: 0.00,
              id: 3,
              deliveryFee: 12.00,
              operationFee: 4.00,
              name: "Carpets",
              image: 'assets/services_carpets.jpeg',
              images: [
                ServiceImage(image: 'assets/carpets_1.jpg'),
                ServiceImage(image: 'assets/carpets_2.jpg'),
              ]),
          lat: 24.2,
          lng: 44.5,
          rating: 5.0,
          address:
              "4135 Ibn Taymeeyah Rd, حي المروة, RLMA6432, 6432, Riyadh 14721",
          userRatingTotal: 25,
          id: 2,
          name: 'Aljabr Laundry',
          placeId: "#place1",
          logo: 'assets/aljabr.png',
          distance: 1.2,
          type: 'register',
          banner: 'assets/blanket_and_linen_banner.jpg',
          seviceTypes: [
            ServiceTypesModel(id: 4, serviceId: 3, type: 'wash'),
          ],
          timeslot: [
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 1),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 2),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 3),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 4),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 5),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 6),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 7),
          ],
          status: 'opened'),

      LaundryModel(
          service: ServicesModel(
              vat: 0.00,
              id: 3,
              deliveryFee: 12.00,
              operationFee: 4.00,
              name: "Carpets",
              image: 'assets/services_carpets.jpeg',
              images: [
                ServiceImage(image: 'assets/carpets_1.jpg'),
                ServiceImage(image: 'assets/carpets_2.jpg'),
              ]),
          lat: 24.2,
          lng: 44.5,
          rating: 5.0,
          address: "MPR5+M2J, Abu Bakr Alrazi St, As Sulimaniyah, Riyadh 12232",
          userRatingTotal: 25,
          id: 2,
          name: 'Al Rahden',
          placeId: "#place1",
          logo: 'assets/al_rahden.png',
          distance: 1.7,
          type: 'register',
          banner: 'assets/blanket_and_linen_banner.jpg',
          seviceTypes: [
            ServiceTypesModel(id: 4, serviceId: 3, type: 'wash'),
          ],
          timeslot: [
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 1),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 2),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 3),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 4),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 5),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 6),
            TimeSlot(
                openTime: TimeOfDay(hour: 7, minute: 0),
                closeTime: TimeOfDay(hour: 0, minute: 0),
                weekNumber: 7),
          ],
          status: 'opened')
    ].where((element) => element.service!.id == serviceId).toList();

    return items;
  }

  Future<List<ItemModel>> getLaundryItemSubCategories(
      {required int itemId}) async {
    List<ItemModel> clothes = [
      ItemModel(
          id: 1,
          name: 'Bed Cover Small',
          laundryId: 1,
          quantity: 0,
          initialCharges: 4,
          charges: 4,
          categoryId: 1,
          serviceId: 2,
          blanketItemId: 1),
      ItemModel(
          id: 2,
          name: 'Bed Cover Medium',
          laundryId: 1,
          quantity: 0,
          initialCharges: 4,
          charges: 4,
          categoryId: 1,
          serviceId: 2,
          blanketItemId: 1),
      ItemModel(
          id: 3,
          name: 'Bed Cover Large',
          laundryId: 1,
          quantity: 0,
          initialCharges: 4,
          charges: 4,
          categoryId: 1,
          serviceId: 2,
          blanketItemId: 1),
      ItemModel(
          id: 4,
          name: 'Bed Spread Small',
          laundryId: 1,
          quantity: 0,
          initialCharges: 4,
          charges: 4,
          categoryId: 1,
          serviceId: 2,
          blanketItemId: 2),
      ItemModel(
          id: 5,
          name: 'Bed Spread Medium',
          laundryId: 1,
          quantity: 0,
          initialCharges: 6,
          charges: 6,
          categoryId: 1,
          serviceId: 2,
          blanketItemId: 2),
      ItemModel(
          id: 6,
          name: 'Bed Spread Large',
          laundryId: 1,
          quantity: 0,
          initialCharges: 8,
          charges: 8,
          categoryId: 1,
          serviceId: 2,
          blanketItemId: 2),
      ItemModel(
          id: 7,
          name: 'Blanket Small',
          laundryId: 1,
          quantity: 0,
          initialCharges: 4,
          charges: 4,
          categoryId: 1,
          serviceId: 2,
          blanketItemId: 3),
      ItemModel(
          id: 8,
          name: 'Blanket Medium',
          laundryId: 1,
          quantity: 0,
          initialCharges: 6,
          charges: 6,
          categoryId: 1,
          serviceId: 2,
          blanketItemId: 3),
      ItemModel(
          id: 9,
          name: 'BlanketLarge',
          laundryId: 1,
          quantity: 0,
          initialCharges: 8,
          charges: 8,
          categoryId: 1,
          serviceId: 2,
          blanketItemId: 3),
      ItemModel(
          id: 10,
          name: 'Guthra Red',
          laundryId: 1,
          quantity: 0,
          initialCharges: 4,
          charges: 4,
          category: 'clothes',
          categoryId: 1,
          serviceId: 1,
          blanketItemId: 12),
      ItemModel(
          id: 11,
          name: 'Guthra White',
          laundryId: 1,
          quantity: 0,
          initialCharges: 4,
          charges: 4,
          category: 'clothes',
          categoryId: 1,
          serviceId: 1,
          blanketItemId: 12),
      ItemModel(
          id: 12,
          name: 'Thobe',
          laundryId: 1,
          quantity: 0,
          initialCharges: 4,
          charges: 4,
          category: 'clothes',
          categoryId: 1,
          serviceId: 1,
          blanketItemId: 11),
      ItemModel(
          id: 13,
          name: 'Scrub',
          laundryId: 1,
          quantity: 0,
          initialCharges: 4,
          charges: 4,
          category: 'clothes',
          categoryId: 1,
          serviceId: 1,
          blanketItemId: 26),
      ItemModel(
          id: 14,
          name: 'Medical Trouser',
          laundryId: 1,
          quantity: 0,
          initialCharges: 4,
          charges: 4,
          category: 'clothes',
          categoryId: 1,
          serviceId: 1,
          blanketItemId: 26),
      ItemModel(
          id: 15,
          name: 'Lab Coat',
          laundryId: 1,
          quantity: 0,
          initialCharges: 4,
          charges: 4,
          category: 'clothes',
          categoryId: 1,
          serviceId: 1,
          blanketItemId: 26),
      ItemModel(
          id: 16,
          name: 'Security Uniform',
          laundryId: 1,
          quantity: 0,
          initialCharges: 4,
          charges: 4,
          category: 'clothes',
          categoryId: 1,
          serviceId: 1,
          blanketItemId: 25),
      ItemModel(
          id: 17,
          name: 'Army Uniform',
          laundryId: 1,
          quantity: 0,
          initialCharges: 4,
          charges: 4,
          category: 'clothes',
          categoryId: 1,
          serviceId: 1,
          blanketItemId: 25),
      ItemModel(
        
          postfixLength: 0,
          postfixWidth: 0,
          prefixLength: 0,
          prefixWidth: 0,
          width: 0.0,
          length: 0.0,
          size: 0.0,
          id: 18,
          name: 'Carpet',
          laundryId: 1,
          quantity: 0,
          initialCharges: 13.0,
          charges: 0,
          category: 'carpets',
          categoryId: 4,
          serviceId: 3,
          blanketItemId: 27),
      ItemModel(
         postfixLength: 0,
          postfixWidth: 0,
          prefixLength: 0,
          prefixWidth: 0,
          id: 19,
          name: 'Mats',
          laundryId: 1,
          quantity: 0,
          initialCharges: 7.0,
          charges: 0,
          category: 'mats',
          categoryId: 4,
          serviceId: 3,
          blanketItemId: 28),
    ];

    await Future.delayed(const Duration(seconds: 1));
    clothes =
        clothes.where((element) => element.blanketItemId == itemId).toList();

    return clothes;
  }
}
