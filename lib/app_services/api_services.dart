import 'package:flutter/material.dart';
import 'package:laundryday/models/blankets_model.dart';
import 'package:laundryday/models/service_types_model.dart';
import 'package:laundryday/models/laundry_model.dart';
import 'package:laundryday/models/service_carousel_images.dart';
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
                ServiceCarouselImage(image: 'assets/clothes_1.jpg'),
                ServiceCarouselImage(image: 'assets/clothes_2.jpg'),
                ServiceCarouselImage(image: 'assets/clothes_3.jpg'),
                ServiceCarouselImage(image: 'assets/clothes_4.jpg'),
                ServiceCarouselImage(image: 'assets/clothes_5.jpg'),
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
              ServiceCarouselImage(image: 'assets/clothes_1.jpg'),
              ServiceCarouselImage(image: 'assets/clothes_2.jpg'),
              ServiceCarouselImage(image: 'assets/clothes_3.jpg'),
              ServiceCarouselImage(image: 'assets/clothes_4.jpg'),
              ServiceCarouselImage(image: 'assets/clothes_5.jpg'),
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
                ServiceCarouselImage(image: 'assets/blankets_1.jpg'),
                ServiceCarouselImage(image: 'assets/blankets_2.jpg'),
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
                ServiceCarouselImage(image: 'assets/blankets_1.jpg'),
                ServiceCarouselImage(image: 'assets/blankets_2.jpg'),
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
                ServiceCarouselImage(image: 'assets/blankets_1.jpg'),
                ServiceCarouselImage(image: 'assets/blankets_2.jpg'),
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
          status: 'opened')
   ,

    LaundryModel(
          service: ServicesModel(
              operationFee: 2.0,
              vat: 15.0,
              id: 2,
              deliveryFee: 18.0,
              name: 'Blankets',
              image: 'assets/services_blankets.jpg',
              images: [
                ServiceCarouselImage(image: 'assets/blankets_1.jpg'),
                ServiceCarouselImage(image: 'assets/blankets_2.jpg'),
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
          status: 'opened')
   
   
   
   
    ].where((element) => element.service!.id == serviceId).toList();

    return items;
  }

  Future<List<LaundryItemModel>> getLaundryItemSubCategories(
      {required int itemId}) async {
    List<LaundryItemModel> clothes = [
      LaundryItemModel(
          id: 1,
          name: 'Bed Cover Small',
          laundryId: 1,
          quantity: 0,
          initialCharges: 4,
          charges: 4,
          categoryId: 1,
          serviceId: 2,
          blanketItemId: 1),
      LaundryItemModel(
          id: 2,
          name: 'Bed Cover Medium',
          laundryId: 1,
          quantity: 0,
          initialCharges: 4,
          charges: 4,
          categoryId: 1,
          serviceId: 2,
          blanketItemId: 1),
      LaundryItemModel(
          id: 3,
          name: 'Bed Cover Large',
          laundryId: 1,
          quantity: 0,
          initialCharges: 4,
          charges: 4,
          categoryId: 1,
          serviceId: 2,
          blanketItemId: 1),
      LaundryItemModel(
          id: 4,
          name: 'Bed Spread Small',
          laundryId: 1,
          quantity: 0,
          initialCharges: 4,
          charges: 4,
          categoryId: 1,
          serviceId: 2,
          blanketItemId: 2),
      LaundryItemModel(
          id: 5,
          name: 'Bed Spread Medium',
          laundryId: 1,
          quantity: 0,
          initialCharges: 6,
          charges: 6,
          categoryId: 1,
          serviceId: 2,
          blanketItemId: 2),
      LaundryItemModel(
          id: 6,
          name: 'Bed Spread Large',
          laundryId: 1,
          quantity: 0,
          initialCharges: 8,
          charges: 8,
          categoryId: 1,
          serviceId: 2,
          blanketItemId: 2),
      LaundryItemModel(
          id: 7,
          name: 'Blanket Small',
          laundryId: 1,
          quantity: 0,
          initialCharges: 4,
          charges: 4,
          categoryId: 1,
          serviceId: 2,
          blanketItemId: 3),
      LaundryItemModel(
          id: 8,
          name: 'Blanket Medium',
          laundryId: 1,
          quantity: 0,
          initialCharges: 6,
          charges: 6,
          categoryId: 1,
          serviceId: 2,
          blanketItemId: 3),
      LaundryItemModel(
          id: 9,
          name: 'BlanketLarge',
          laundryId: 1,
          quantity: 0,
          initialCharges: 8,
          charges: 8,
          categoryId: 1,
          serviceId: 2,
          blanketItemId: 3),
      LaundryItemModel(
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
      LaundryItemModel(
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
      LaundryItemModel(
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
      LaundryItemModel(
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
      LaundryItemModel(
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
      LaundryItemModel(
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
      LaundryItemModel(
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
      LaundryItemModel(
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
    ];

    await Future.delayed(const Duration(seconds: 1));
    clothes =
        clothes.where((element) => element.blanketItemId == itemId).toList();

    return clothes;
  }
}
