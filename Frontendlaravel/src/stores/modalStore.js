import { defineStore } from 'pinia';
import { ref } from 'vue';

export const useModalStore = defineStore('modal', () => {
  const isOpen = ref(false);
  const options = ref({
    title: 'Confirmación',
    message: '¿Estás seguro de realizar esta acción?',
    confirmText: 'Confirmar',
    cancelText: 'Cancelar',
    type: 'warning', // warning, danger, success, info
    onConfirm: () => {},
    onCancel: () => {}
  });

  const openModal = (config) => {
    options.value = {
      title: config.title || 'Confirmación',
      message: config.message || '¿Estás seguro?',
      confirmText: config.confirmText || 'Confirmar',
      cancelText: config.cancelText || 'Cancelar',
      type: config.type || 'warning',
      onConfirm: config.onConfirm || (() => {}),
      onCancel: config.onCancel || (() => {})
    };
    isOpen.value = true;
  };

  const closeModal = () => {
    isOpen.value = false;
  };

  const confirm = () => {
    if (options.value.onConfirm) options.value.onConfirm();
    closeModal();
  };

  const cancel = () => {
    if (options.value.onCancel) options.value.onCancel();
    closeModal();
  };

  return {
    isOpen,
    options,
    openModal,
    closeModal,
    confirm,
    cancel
  };
});
